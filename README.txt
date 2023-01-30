Nom : BELKADI NESRINE 
le ficher .sql est associé au projet .
commencez par la page login.html

1/L'ajout des fonctions serveur 
cote serveur : 
J'ai ajouté des api pour : 
 - afficher la liste de pays 
 - afficher la liste de joueurs ( j'ai ajouter une table de Players contenant l'id , nom , age , position , id-country (nationalite) , id-club et une photo  )
   pour cette table ; j'ai associé une clé primaire et 2 cles etrangere ( id-club ,id-country )
 - cree un joueur 
 - supprimer un club 
 - recuperer un seul joueur 
 - recuperer la liste des joueurs d'un club 
 NB : j'ai changé le type de la date dans la table des matches en datetime pour pouvoir afficher le format de la date : yyyy-mm-dd hh-mm-ss 
 car au paravant la date etait de type : date :yyyy-mm-dd
cote client : 
vous allez trouver toutes les pages html pour faire le fetch de la bd : 


2/ API weather : 
j'ai utilisé l'api api.weatherapi.com/v1/forecast.json , j'ai pris 2 parametres : 
  - la ville 
  - la date ( qui ne doit pas depasser 14 jours de la date courante )
J'ai commencé par afficher une liste des matches pas encore joués (NotYetPlayed.html) en comparant 
la date d'aujourd'hui avec la date du match , j'ai utilisé l'api listMatch (la meme utilisé pour afficher tout les matches )
  - acoté de chaque match non joué j'ai ajouter un bouton 'GET WEATHER ' pour afficher la méteo du jour 
  -si un utilisateur appuie sur le bouton get weather il va se redriger vers une page html getweather.html 
  avec l'id du match comme parametre , dans cette page , j'ai affiché toutes les infos sur la méteo 
  sun(rise/set), moon(rise/set) , temperatue en °C max et min , wind ... , icon de la méteo par heure ..etc 
  cette solution travaille seulement pour les matches organisé dans les 14 jours suivant 
  car l'api affiche seulemnt la méteo pour les 14 jours suivants  

3/la partie WebSocket : 
 j'ai fait seulemnt la partie connexion entre serveur et un client apres son connexion  .