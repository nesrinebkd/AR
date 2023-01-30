const express = require('express');
const app = express();
const mysql = require('mysql2');
const jwt = require('jsonwebtoken');
const auth = require('./authorization');
const WebSocket = require('ws');
//connection
const conx = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'ige42',
});

//Web Sockets

const wss = new WebSocket.Server({ port: 84 });
const clients = new Map(); // dictionnaire des clients connectés
wss.on('connection', (ws) => {
  clients.set(ws);
  ws.on('message', function (data) {
    console.log("message d'un client: ", data.toString());
  });
});
app.use(function (req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization'
  );
  res.setHeader(
    'Access-Control-Allow-Methods',
    'GET, POST, PUT, DELETE, PATCH, OPTIONS'
  );
  next();
});
// se connecter
app.get('/login', function (req, res, next) {
  const user = req.query.user;
  const password = req.query.password;
  conx.execute(
    'select id, nom, role, password from users where nom = ?',
    [user],
    function (err, data) {
      if (err) {
        res.status(500).send({ error: err });
      } else if (data.length < 1) {
        res.status(401).send({ msg: 'Utilisateur inconnu' });
      } else {
        if (password === data[0].password) {
          const token = jwt.sign(
            { id: data[0].id, role: data[0].role },
            'ige42',
            { expiresIn: '24h' }
          );
          res.status(200).send({
            jwt: token,
            userName: data[0].nom,
            userId: data[0].id,
            role: data[0].role,
          });
        } else {
          res.status(401).send({ msg: 'Mot de passe incorrect' });
        }
      }
    }
  );
});
// afficher la liste de clubs
app.use(express.json());
app.get('/api/listClubs', (req, res) => {
  conx.query('select  id,nom , logo from clubs', (err, data, fields) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log('done');
      res.status(200).send(data);
    }
  });
});
//afficher la liste de pays
app.get('/api/listPays', (req, res) => {
  conx.query('select  id,nom from pays', (err, data, fields) => {
    if (err) {
      res.status(500).send(err);
    } else {
      console.log('done');
      res.status(200).send(data);
    }
  });
});
//liste des Joueurs
app.get('/api/listJoueurs', (req, res) => {
  conx.query(
    `SELECT p.player_id,p.id_country,p.id_club,p.photo, 
  (select nom from clubs where clubs.id = p.id_club) as 'club',
  (select nom from pays where pays.id = p.id_country) as 'country',
  p.name,p.Age,p.position,p.photo 
  from players AS p`,

    (err, data, fields) => {
      if (err) {
        res.status(500).send(err);
      } else {
        console.log('done');
        res.status(200).send(data);
      }
    }
  );
});
//create match
app.post('/api/createMatch', auth, (req, res) => {
  const data = req.body;
  console.log(data);
  console.log(
    "insert into matches (id_guest,id_visitor,date) values('" +
      Object.values(data).join("','") +
      "')"
  );
  conx.execute(
    "insert into matches (id_guest,id_visitor,date) values('" +
      Object.values(data).join("','") +
      "')",
    function (err, r) {
      if (err) {
        res.status(501).send(err);
      } else {
        res.status(201).send('Insertion bien effectuée !');
      }
    }
  );
});
//create club
app.post('/api/createClub', (req, res) => {
  const data = req.body;
  conx.execute(
    "insert into clubs (id_pays,nom,ville,logo) values('" +
      Object.values(data).join("','") +
      "')",
    function (err, r) {
      if (err) {
        res.status(501).send(err);
      } else {
        res.status(201).send('Insertion bien effectuée !');
      }
    }
  );
});
//creer un joueur
app.post('/api/createPlayer', (req, res) => {
  const data = req.body;
  console.log(
    "insert into players (name,Age,position,id_country,id_club,photo) values('" +
      Object.values(data).join("','") +
      "')"
  );
  conx.execute(
    "insert into players (name,Age,position,id_country,id_club,photo) values('" +
      Object.values(data).join("','") +
      "')",
    function (err, r) {
      if (err) {
        res.status(501).send(err);
      } else {
        res.status(201).send('Insertion bien effectuée !');
      }
    }
  );
});
//liste dea matches
app.get('/api/listMatch', auth, (req, res, next) => {
  conx.query(
    `SELECT m.id, m.id_guest, m.id_visitor, 
    (select nom from clubs where clubs.id = m.id_guest) as 'name_guest',
    (select logo from clubs where clubs.id = m.id_guest) as 'logo_guest',
    (SELECT ville from clubs where clubs.id = m.id_guest) as 'city', 
    (select nom from clubs where clubs.id = m.id_visitor) as 'name_visitor',
    (select logo from clubs where clubs.id = m.id_visitor) as 'logo_visitor',
    m.score_guest, m.score_visitor, m.date 
    from matches AS m
`,
    (err, data, fields) => {
      if (err) {
        res.status(500).send(err);
      } else {
        res.status(200).send({ matches: data });
      }
    }
  );
});
//supprimer un match
app.delete('/api/deleteMatche/:id', auth, (req, res) => {
  let id = req.params.id;
  const role = req.payload.role;
  if (role === 'admin') {
    conx.execute('delete from matches where id = ' + id, function (err, r) {
      if (err) {
        res.status(500).send({ error: err });
      }
      res.status(200).send({ message: 'Suppression bien effectuée !' });
    });
  } else {
    res
      .status(401)
      .send({ message: "Vous n'êtes pas autorisé à supprimer des matches" });
  }
});
//supprimer un club
app.delete('/api/deleteClub/:id', (req, res) => {
  let id = req.params.id;
  conx.execute('delete from clubs where id = ' + id, function (err, r) {
    if (err) {
      res.status(500).send({ error: err });
    }
    res.status(200).send({ message: 'Suppression bien effectuée !' });
  });
});
//recuperation d'un seul matche
app.get('/api/matche/:id', auth, (req, res, next) => {
  let id = req.params.id;
  conx.query(
    `
  SELECT m.id, m.id_guest, m.id_visitor, 
  (select nom from clubs where clubs.id = m.id_guest) as 'name_guest',
  (select logo from clubs where clubs.id = m.id_guest) as 'logo_guest',
  (SELECT ville from clubs where clubs.id = m.id_guest) as 'city', 
  (select nom from clubs where clubs.id = m.id_visitor) as 'name_visitor',
  (select logo from clubs where clubs.id = m.id_visitor) as 'logo_visitor',
  m.score_guest, m.score_visitor, m.date 
  from matches AS m where m.id = ${id}
`,
    function (err, data) {
      if (err) {
        res.status(500).send({ error: err });
      }
      res.status(200).send({ matche: data[0] });
    }
  );
});
// recuperation d'un seul joueur
app.get('/api/Player/:id', (req, res) => {
  let id = req.params.id;
  conx.query(
    `SELECT p.player_id,p.id_country,p.id_club,p.photo, 
    (select nom from clubs where clubs.id = p.id_club) as 'club',
    (select nom from pays where pays.id = p.id_country) as 'country',
    p.name,p.Age,p.position,p.photo 
    from players AS p where p.player_id = ${id}
  
`,
    function (err, data) {
      if (err) {
        res.status(500).send({ error: err });
      }
      res.status(200).send({ player: data });
    }
  );
});
// update le score d'un match
app.put('/api/updateScore/:id', auth, (req, res) => {
  let id = req.params.id;
  const score = req.body;
  conx.execute(
    'update matches set score_guest = ' +
      score.guest +
      ', score_visitor = ' +
      score.visitor +
      ' where id = ' +
      id,
    function (err, r) {
      if (err) {
        res.status(500).send({ error: err });
      }
      res.status(200).send({ message: 'Mise à jour bien effectuée !' });
    }
  );
});
//recuperer la liste de joueurs d'un club
app.get('/api/PlayersClub/:id', (req, res) => {
  let id = req.params.id;
  conx.query(
    `SELECT p.player_id,p.id_country,p.id_club,p.photo, 
  (select nom from clubs where clubs.id = p.id_club) as 'club',
  (select nom from pays where pays.id = p.id_country) as 'country',
  p.name,p.Age,p.position,p.photo 
  from players AS p where p.id_club=${id}`,
    function (err, data) {
      if (err) {
        res.status(500).send({ error: err });
      }
      res.status(200).send(data);
    }
  );
});
app.listen(3200, () => {
  console.log('application connecté sur le port 3200 ');
});
