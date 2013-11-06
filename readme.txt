-------------------------------------------
|										  |
|			OTHELLO - PROLOG			  |
|										  |
-------------------------------------------

I/ Notations

Pour faire jouer l'IA jouant aléatoirement :
	
	rand

Pour faire jouer l'IA jouant le premier coup qu'elle trouve :

	lazy

Pour faire jouer l'IA qui retourne le plus de pions possible à chaque tour :

	mr

Pour faire jouer l'IA jouant les coups qui rapportent le plus de points :
	
	pos

Pour faire jouer l'IA minimax basée sur les règles de mr :

	mmMR

Pour faire jouer l'IA minimax basée sur les règles de pos :

	mmPOS


II/ Jouer sous linux

Dans l'invite de commande shell, taper :

	> sh othello.sh [param1] [param2]

avec en paramètre les noms des IAs devant s'affronter.
Param1 jouera en vert (= joue en premier) et param2 jouera en rouge (= joue en deuxième).

III/ Jouer sous Windows

Lancer le programme prolog, puis enter les commandes :
	
	> consult(main).
	> playAll([param1,param2]).

Avec param1 et param2 se comportant comme dans la partie II/

IV/ Nota Bene

Pour enlever le timer entre chaque display de plateau (surtout pour les IAs minimax deja longues), éditer le fichier main.pl, et retirer la ligne (49 normalement) :

	sleep(O.5),

Les résultats des séries de test se trouvent dans le fichier :
	compteRendu.txt