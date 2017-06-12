{
ALGORITHME : Morpions
Une partie se déroule avec 2 joueurs, l'un choisi les croix l'autre les ronds. Le joueur qui commence est
choisi au hasard.


CONST 
	MaxCell=3
	NbToursMax=9
	NbJoueurs=2

Type
	RondCroix = (X,O)
	Victoire = (VictoireJ1,VictoireJ2)

Type Joueur = ENREGISTREMENT
		Symbole:RondCroix
		NbMancheGagnee:Entier
		Nom:chaine
FIN ENREGISTREMENT

Type
	TabMorp=Tableau [1..3,1..3] de car
	TabJ=Tableau[1..NbJoueurs] de Joueur

procedure Initiatilisation(VAR Morp:TabMorp)

VAR
	i,j:entier

DEBUT //Revoir Initialisation
	POUR i DE 1 A MaxCell FAIRE
		POUR j DE 1 A MaxCell FAIRE
				Morp[i,j]<-" "
		FINPOUR
	FINPOUR
FIN

procedure Affichage(Morp:TabMorp)

VAR
	i,j:entier

DEBUT
	POUR i DE 1 A MaxCell FAIRE
		POUR j DE 1 A MaxCell FAIRE
			SI (j=MaxCell) ALORS
				ECRIRE(Morp[i,j])
			SINON
				ECRIRE(Morp[i,j],'|')
		FINPOUR
		ECRIRE() // Saut de ligne
		POUR j DE 1 A MaxCell FAIRE
			SI (i<>MaxCell) ALORS
				ECRIRE("--")
		FINPOUR
		ECRIRE() //Fonction saut de ligne 
	FINPOUR
FIN

FONCTION ChoixJoueur:ENTIER

VAR
	J:entier
	nb:entier

DEBUT
	// Fonction permettant de créer un aléatoire randomize
	nb<-random((2)+1)
	SI (nb=1) alors
		J<-1
	SINON
		J<-2
	FINSI

	ChoixJoueur<-J
FIN

procedure ChoixNom(Var TabJoueur:TabJ)
BUT : Permet aux joueurs de choisir leurs pseudos pour la partie
ENTREES : Noms des 2 joueurs

VAR
	i:ENTIER
	NomJ:CHAINE

DEBUT
	ECRIRE("Choix du nom : ")
	POUR i DE 1 A NbJoueurs FAIRE
		ECRIRE("Veuillez entrer le nom du joueur ",i)
		LIRE(NomJ)
		TabJoueur[i].Nom<-NomJ
	FINPOUR
FIN

procedure ChoixRC(VAR TabJoueur:TabJ;J:entier)

VAR
	RC,RC2:RondCroix
	i:entier

DEBUT
	ECRIRE(TabJoueur[J].Nom," commence et peut choisir son symbole")

	REPETER 
			ECRIRE("Taper 'X' ou 'O' pour choisir")
			LIRE(RC)
	JUSQU'A (RC=X) OU (RC=O)

	TabJoueur[J].Symbole<-RC
	
	SI RC=X alors
		RC2<-O
	SINON
		RC2<-X
	FINSI

	SI J=1 alors
		TabJoueur[2].Symbole<-RC2
	SINON
		TabJoueur[1].Symbole<-RC2
	FINSI

	POUR i DE 1 A NbJoueurs FAIRE
		ECRIRE(TabJoueur[i].Nom," jouera avec les ",TabJoueur[i].Symbole)
	FINPOUR

FIN

FONCTION VideOk(L,C:Entier;Morp:TabMorp):boolean

DEBUT
	SI (Morp[L,C]<>' ') ALORS
		VideOk<-FAUX
	SINON
		VideOk<-VRAI
	FINSI
FIN

procedure Placement(VAR Morp:TabMorp;TabJoueur:TabJ;Joueur:Entier)

VAR
	PosChaine:chaine
	L,C:entier
	TestVide:booleen
	Symb:car
	TestSaisie:booleen

DEBUT
	REPETER
		REPETER 

			TestSaisie<-VRAI
			ECRIRE("Veuillez placer votre symbole - Saisir de cette maniere (L/C)");
			LIRE(PosChaine);
			L<-StrToInt(Extraction(PosChaine,1,1)) //Appel d'une fonction de changement de type d'une chaine à un entier
			C<-StrToInt(Extraction(PosChaine,3,1))
			SI ((L<1) ET (L>3)) ET ((C<1) ET (C>3)) ALORS
				TestSaisie<-FAUX
				ECRIRE("Erreur de saisie - Recommencer")
			FINSI

		JUSQU'A (TestSaisie=VRAI)
			TestVide<-VideOk(L,C,Morp) // Fait appel à la fonction VideOk qui vérifie si la cellule du tableau est vide.
			SI (TestVide=FALSE)
				ECRIRE("Erreur de saisie - Recommencer")
			FINSI
	JUSQU'A (TestVide=VRAI)	

	SI TestVide=VRAI ALORS
		SI TabJoueur[Joueur].Symbole=O ALORS
			Symb<-'O'
		SINON
			Symb<-'X'
		FINSI
		Morp[L,C]<-Symb
	FINSI
FIN	

procedure Alignement(Morp:TabMorp;TabJoueur:TabJ;VAR Vict:Victoire)

DEBUT
	SI ((Morp[1,1]='X') ET (Morp[1,2]='X') ET (Morp[1,3]='X')) OU ((Morp[2,1]='X') ET (Morp[2,2]='X') ET (Morp[2,3]='X'))
	OU ((Morp[3,1]='X') ET (Morp[3,2]='X') ET (Morp[3,3]='X')) OU ((Morp[1,1]='X') ET (Morp[2,1]='X') ET (Morp[3,1]='X'))
	OU ((Morp[1,2]='X') ET (Morp[2,2]='X') ET (Morp[3,2]='X')) OU ((Morp[1,3]='X') ET (Morp[2,3]='X') ET (Morp[3,3]='X'))
	OU ((Morp[1,1]='X') ET (Morp[2,2]='X') ET (Morp[3,3]='X')) OU ((Morp[3,1]='X') ET (Morp[2,2]='X') ET (Morp[1,3]='X'))
	ALORS
		SI TabJoueur[1].Symbole=X ALORS
			Vict<-VictoireJ1
		SINON
			Vict<-VictoireJ2
		FINSI
	FINSI

	SI ((Morp[1,1]='O') ET (Morp[1,2]='O') ET (Morp[1,3]='O')) OU ((Morp[2,1]='O') ET (Morp[2,2]='O') ET (Morp[2,3]='O'))
	OU ((Morp[3,1]='O') ET (Morp[3,2]='O') ET (Morp[3,3]='O')) OU ((Morp[1,1]='O') ET (Morp[2,1]='O') ET (Morp[3,1]='O'))
	OU ((Morp[1,2]='O') ET (Morp[2,2]='O') ET (Morp[3,2]='O')) OU ((Morp[1,3]='O') ET (Morp[2,3]='O') ET (Morp[3,3]='O'))
	OU ((Morp[1,1]='O') ET (Morp[2,2]='O') ET (Morp[3,3]='O')) OU ((Morp[3,1]='O') ET (Morp[2,2]='O') ET (Morp[1,3]='O'))
	ALORS
		SI TabJoueur[1].Symbole=O ALORS
			Vict<-VictoireJ1
		SINON
			Vict<-VictoireJ2
		FINSI
	FINSI
FIN

procedure TourDeJeu(VAR Morp:TabMorp;VAR J:entier;VAR TabJoueur:TabJ)

VAR
	i:entier
	PosChaine:chaine
	L,C:entier
	Vict:Victoire

DEBUT
	i<-0
	REPETER
		Clear // Appel de la fonction clrscr pour "nettoyer" l'écran
		i<-i+1
		Affichage(Morp)
		SI J=1 ALORS
			ECRIRE("Tour ",i," : ",TabJoueur[J].Nom," joue les ",TabJoueur[J].Symbole)
			Placement(Morp,TabJoueur,J)
			Alignement(Morp,TabJoueur,Vict)
			J<-J+1
			Attendre// Appel de la fonction readln pour laisser l'affichage
		SINON
			ECRIRE("Tour ",i," : ",TabJoueur[J].Nom," joue les ",TabJoueur[J].Symbole)
			Placement(Morp,TabJoueur,J)
			Alignement(Morp,TabJoueur,Vict)
			J<-J-1
			Attendre// Appel de la fonction readln pour laisser l'affichage
		FINSI
	JUSQU'A ((i=NbToursMax) OU (Vict=VictoireJ1) OU (Vict=VictoireJ2));

	SI (Vict=VictoireJ1) ALORS
		Affichage(Morp)
		ECRIRE(TabJoueur[1].Nom," a gagné la manche !")
		TabJoueur[1].NbMancheGagnee:=TabJoueur[1].NbMancheGagnee+1
	FINSI

	SI (Vict=VictoireJ2) ALORS
		Affichage(Morp)
		ECRIRE(TabJoueur[J].Nom," a gagné la manche !")
		TabJoueur[2].NbMancheGagnee:=TabJoueur[2].NbMancheGagnee+1
	FINSI

	SI ((i=NbToursMax) ET NON (Vict=VictoireJ1) ET NON (Vict=VictoireJ2)) ALORS
		Affichage(Morp)
		ECRIRE("Egalité")
	FINSI

FIN

procedure ManchesGagnees(TabJoueur:TabJ)
//BUT : Afficher les manches gagnées des joueurs

VAR i:ENTIER

DEBUT
	Clear // Appel de la fonction clrscr pour "nettoyer" l'écran
	ECRIRE("Nombre de manche(s) gagnée(s)")
	POUR i DE 1 A NbJoueurs FAIRE
		ECRIRE(TabJoueur[i].Nom," : ",TabJoueur[i].NbMancheGagnee)
	FINPOUR
FINPROCEDURE

procedure PartieGagnee(TabJoueur:TabJ;Var FichierMorpion:Text)
//BUT Afficher le joueur gagnant et inscrire la partie dans un fichier

VAR
	chaine:CHAINE

DEBUT
	SI (TabJoueur[1].NbMancheGagnee > TabJoueur[2].NbMancheGagnee) ALORS
		ECRIRE(TabJoueur[1].Nom," a gagné la partie")
		//La chaine prend l'heure actuelle (fonction de récupération de l'heure) et transformation d'un entier en chaine (fonction IntToStr)
		chaine<-(TimeToStr(Time)+" => "+TabJoueur[1].Nom+" a gagné contre"+TabJoueur[2].Nom+" / Manche(s) gagnée(s) : "+IntToStr(TabJoueur[1].NbMancheGagnee))
		ECRIRE(FichierMorpion,chaine)
	SINON
		SI (TabJoueur[2].NbMancheGagnee > TabJoueur[1].NbMancheGagnee) then
			ECRIRE(TabJoueur[2].Nom," a gagné la partie")
			chaine<-(TimeToStr(Time)+" => "+TabJoueur[1].Nom+" a gagné contre "+TabJoueur[2].Nom+" / Manche(s) gagnée(s) : "+IntToStr(TabJoueur[2].NbMancheGagnee));
			ECRIRE(FichierMorpion,chaine)
		SINON
			ECRIRE("Pas de gagnant !")
		FINSI
	FINSI
FINPROCEDURE

//Programme principal :

VAR 
	Morp:TabMorp
	J:entier
	TabJoueur:TabJ
	manche:entier
	i:entier
	FichierMorpion:Text
	Vict:Victoire
	chaine:CHAINE

DEBUT
	Clear // Appel de la fonction clrscr qui "nettoie" l'écran
	ECRIRE("Jeu du MORPION")
	ChoixNom(TabJoueur)
	ECRIRE("Entrez le nombre de manches que vous voulez jouer")
	LIRE(manche)
	POUR i DE 1 A manche FAIRE
		Clear // Appel de la fonction clrscr qui "nettoie" l'écran
		Initiatilisation(Morp)
		Affichage(Morp)

		J:=ChoixJoueur

		ChoixRC(TabJoueur,J)

		Attendre //Appel de la fonction readln pour laisser l'affichage

		TourDeJeu(Morp,J,TabJoueur)
	FINPOUR

	ManchesGagnees(TabJoueur) // Appel de la procédure ManchesGagnees

	ASSIGNER(FichierMorpion,'morpion.txt')

	AJOUTER(FichierMorpion)

	PartieGagnee(TabJoueur,FichierMorpion) //Appel de la procédure PartieGagnee
	
	FERMER(FichierMorpion)

	Attendre //Appel de la fonction readln pour laisser l'affichage
FIN
}

Program Morpion;

uses crt,sysutils,dateutils;

CONST 
	MaxCell=3;
	NbToursMax=9;
	NbJoueurs=2;

Type
	RondCroix = (X,O);
	Victoire = (VictoireJ1,VictoireJ2);

Type Joueur = RECORD
		Symbole:RondCroix;
		NbMancheGagnee:integer;
		Nom:string;
END;

Type
	TabMorp=Array [1..MaxCell,1..MaxCell] of char;
	TabJ=Array[1..NbJoueurs] of Joueur;

procedure Initiatilisation(VAR Morp:TabMorp); 
//BUT : Initialise le tableau du morpion qui contiendra soit les X soit les O

VAR
	i,j:integer;

BEGIN
	for i:=1 to MaxCell do
		BEGIN
			for j:=1 to MaxCell do
				BEGIN
					Morp[i,j]:=' ';
				END;
		END;

END;

procedure Affichage(Morp:TabMorp);
//BUT: Procédure d'affichage du tableau contenant les X et les O

VAR
	i,j:integer;

BEGIN
	for i:=1 to MaxCell do
		BEGIN
			for j:=1 to MaxCell do
				BEGIN
					if (j=MaxCell) then
						write(Morp[i,j])
					else
						write(Morp[i,j],'|');
				END;
			writeln;
			for j:=1 to MaxCell do
				BEGIN
					if i<>MaxCell then
						write('--');
				END;
			writeln;	
		END;
END;

function ChoixJoueur:integer;
{BUT :Fonction choisissant le joueur qui commence de manière aléatoire. SI nb=1 alors le joueur qui commence est le 
joueur 1 sinon c'est le joueur 2}
VAR
	J:integer;
	nb:integer;

BEGIN
	randomize;
	nb:=random((NbJoueurs)+1);
	if (nb=1) then
		J:=1
	else
		J:=2;
	ChoixJoueur:=J;
END;

procedure ChoixNom(Var TabJoueur:TabJ);
{BUT : Permet aux joueurs de choisir leurs pseudos pour la partie
ENTREES : Noms des 2 joueurs}

VAR
	i:integer;
	NomJ:string;

BEGIN
	writeln('Choix du nom : ');
	FOR i:=1 TO NbJoueurs DO
		begin
			writeln('Veuillez entrer le nom du joueur ',i);
			readln(NomJ);
			TabJoueur[i].Nom:=NomJ;
		end;
END;

procedure ChoixRC(VAR TabJoueur:TabJ;J:integer);
//BUT : Procédure déterminant quel joueur utilise quel symbole et affiche le joueur et le symbole correspondant
//Entrees :Choix Ronc Croix
//SORTIES : Symbole de chaque joueur
VAR
	RC,RC2:RondCroix;
	i:integer;

BEGIN
	writeln(TabJoueur[J].Nom,' commence et peut choisir son symbole');

	REPEAT 
		begin
			writeln('Taper "X" ou "O" pour choisir');
			readln(RC);
		end;
	UNTIL (RC=X) OR (RC=O) ;

	TabJoueur[J].Symbole:=RC;
	
	if RC=X then
		RC2:=O
	else
		RC2:=X;

	if J=1 then
		TabJoueur[2].Symbole:=RC2
	else
		TabJoueur[1].Symbole:=RC2;

	FOR i:=1 TO 2 DO
		begin
			writeln(TabJoueur[i].Nom,' jouera avec les ',TabJoueur[i].Symbole);
		end;
END;

function VideOk(L,C:integer;Morp:TabMorp):boolean;
//BUT : Fonction vérifiant si la cellule du tableau est vide. Si elle est vide alors function = VRAI

BEGIN
	if (Morp[L,C]<>' ') then
		VideOk:=FALSE
	else
		VideOk:=TRUE;
END;

procedure Placement(VAR Morp:TabMorp;TabJoueur:TabJ;Joueur:integer);
//BUT : Procédure qui permet de placer son symbole dans le tableau du morpion
//ENTREES : Coordonnées dans la grille du morpion

VAR
	PosChaine:string;
	L,C:integer;
	TestVide:boolean;
	Symb:char;
	TestSaisie:boolean;

BEGIN
	REPEAT
		begin
			REPEAT
				TestSaisie:=TRUE;
				writeln('Veuillez placer votre symbole - Saisir de cette maniere (L/C)');
				readln(PosChaine);
				L:=StrToInt(copy(PosChaine,1,1));
				C:=StrToInt(copy(PosChaine,3,1));
				IF ((L<1) AND (L>3)) AND ((C<1) AND (C>3)) then
					BEGIN
						TestSaisie:=FALSE;
						writeln('Erreur de saisie - Recommencer');
					END;
			UNTIL TestSaisie=TRUE;
			TestVide:=VideOk(L,C,Morp); // Fait appel à la fonction VideOk qui vérifie si la cellule du tableau est vide.
			IF (TestVide=FALSE) then
					BEGIN
						writeln('Erreur de saisie - Recommencer');
					END;
		end;
	UNTIL (TestVide=TRUE);	

	if TestVide=TRUE then //Si le test est vrai alors on insère le symbole correspondant au joueur
		begin
			if TabJoueur[Joueur].Symbole=O then
				Symb:='O'
			else
				Symb:='X';
			Morp[L,C]:=Symb;
		end;
END;			

procedure Alignement(Morp:TabMorp;TabJoueur:TabJ;VAR Vict:Victoire);
//BUT : Vérification de l'alignement de 3 symboles identiques 

BEGIN
	if ((Morp[1,1]='X') AND (Morp[1,2]='X') AND (Morp[1,3]='X')) OR ((Morp[2,1]='X') AND (Morp[2,2]='X') AND (Morp[2,3]='X'))
	OR ((Morp[3,1]='X') AND (Morp[3,2]='X') AND (Morp[3,3]='X')) OR ((Morp[1,1]='X') AND (Morp[2,1]='X') AND (Morp[3,1]='X'))
	OR ((Morp[1,2]='X') AND (Morp[2,2]='X') AND (Morp[3,2]='X')) OR ((Morp[1,3]='X') AND (Morp[2,3]='X') AND (Morp[3,3]='X'))
	OR ((Morp[1,1]='X') AND (Morp[2,2]='X') AND (Morp[3,3]='X')) OR ((Morp[3,1]='X') AND (Morp[2,2]='X') AND (Morp[1,3]='X'))
	then
		if TabJoueur[1].Symbole=X then
			Vict:=VictoireJ1
		else
			Vict:=VictoireJ2;

	if ((Morp[1,1]='O') AND (Morp[1,2]='O') AND (Morp[1,3]='O')) OR ((Morp[2,1]='O') AND (Morp[2,2]='O') AND (Morp[2,3]='O'))
	OR ((Morp[3,1]='O') AND (Morp[3,2]='O') AND (Morp[3,3]='O')) OR ((Morp[1,1]='O') AND (Morp[2,1]='O') AND (Morp[3,1]='O'))
	OR ((Morp[1,2]='O') AND (Morp[2,2]='O') AND (Morp[3,2]='O')) OR ((Morp[1,3]='O') AND (Morp[2,3]='O') AND (Morp[3,3]='O'))
	OR ((Morp[1,1]='O') AND (Morp[2,2]='O') AND (Morp[3,3]='O')) OR ((Morp[3,1]='O') AND (Morp[2,2]='O') AND (Morp[1,3]='O'))
	then
		if TabJoueur[1].Symbole=O then
			Vict:=VictoireJ1
		else
			Vict:=VictoireJ2;

END;

procedure TourDeJeu(VAR Morp:TabMorp;VAR J:integer;VAR TabJoueur:TabJ);
//BUT :Procédure définissant les tours de jeu appellant les procédures d'alignement et de placement

VAR
	i:integer;
	PosChaine:string;
	L,C:integer;
	Vict:Victoire;

BEGIN
	i:=0;
	REPEAT
		begin
			clrscr;
			i:=i+1;
			Affichage(Morp);
			if J=1 then
				begin
					writeln('Tour ',i,' : ',TabJoueur[J].Nom,' joue les ',TabJoueur[J].Symbole);
					Placement(Morp,TabJoueur,J);
					Alignement(Morp,TabJoueur,Vict);
					J:=J+1;
				end
			else
				BEGIN
					writeln('Tour ',i,' : ',TabJoueur[J].Nom,' joue les ',TabJoueur[J].Symbole);
					Placement(Morp,TabJoueur,J);
					Alignement(Morp,TabJoueur,Vict);
					J:=J-1;
				end;
		end;
	UNTIL ((i=NbToursMax) OR (Vict=VictoireJ1) OR (Vict=VictoireJ2)); // Vérifie le nombre de tour ou s'il y a victoire d'un joueur

	if Vict=VictoireJ1 then 
		begin
			Affichage(Morp);
			writeln(TabJoueur[1].Nom,' a gagné la manche !');
			TabJoueur[1].NbMancheGagnee:=TabJoueur[1].NbMancheGagnee+1;
		end;

	if Vict=VictoireJ2 then
		begin
			Affichage(Morp);
			writeln(TabJoueur[2].Nom,' a gagné la manche !');
			TabJoueur[2].NbMancheGagnee:=TabJoueur[2].NbMancheGagnee+1;	
		end;

	if ((i=NbToursMax) AND NOT (Vict=VictoireJ1) AND NOT (Vict=VictoireJ2)) then 
		BEGIN
			Affichage(Morp);
			writeln('Egalité');
		END;
		

	readln;
END;

procedure ManchesGagnees(TabJoueur:TabJ);
//BUT : Afficher les manches gagnées des joueurs

VAR i:integer;

BEGIN
	clrscr;
	writeln('Nombre de manche(s) gagnée(s)');
	FOR i:=1 to NbJoueurs DO
		begin
			writeln(TabJoueur[i].Nom,' : ',TabJoueur[i].NbMancheGagnee);
		end;
END;

procedure PartieGagnee(TabJoueur:TabJ;Var FichierMorpion:Textfile);
//BUT Afficher le joueur gagnant et inscrire la partie dans un fichier

VAR
	chaine:string;

BEGIN
	if (TabJoueur[1].NbMancheGagnee > TabJoueur[2].NbMancheGagnee) then
		begin
			writeln(TabJoueur[1].Nom,' a gagné la partie');
			chaine:=(TimeToStr(Time)+' => '+TabJoueur[1].Nom+' a gagné contre'+TabJoueur[2].Nom+' / Manche(s) gagnée(s) : '+IntToStr(TabJoueur[1].NbMancheGagnee));
			writeln(FichierMorpion,chaine);
		end
	else
		begin
			if (TabJoueur[2].NbMancheGagnee > TabJoueur[1].NbMancheGagnee) then
				begin
					writeln(TabJoueur[2].Nom,' a gagné la partie');
					chaine:=(TimeToStr(Time)+' => '+TabJoueur[1].Nom+' a gagné contre '+TabJoueur[2].Nom+' / Manche(s) gagnée(s) : '+IntToStr(TabJoueur[2].NbMancheGagnee));
					writeln(FichierMorpion,chaine);
				end
			else 
				writeln('Pas de gagnant !');
		end;
END;

//Programme principal :

VAR 
	Morp:TabMorp;
	J:integer;
	TabJoueur:TabJ;
	manche:integer;
	i:integer;
	FichierMorpion:Textfile;
	Vict:Victoire;
	chaine:string;

BEGIN
	clrscr;
	writeln('Jeu du MORPION');
	ChoixNom(TabJoueur);
	writeln('Entrez le nombre de manches que vous voulez jouer');
	readln(manche);
	FOR i:=1 TO manche DO
		begin
			clrscr;
			Initiatilisation(Morp); //Appel de la procédure initialisation
			Affichage(Morp); //Appel de la procédure affichage

			J:=ChoixJoueur; //Appel de la fonction choixjoueur qui commencera la manche

			ChoixRC(TabJoueur,J); //Appel de la procédure choix rond ou croix
			readln;

			TourDeJeu(Morp,J,TabJoueur); //Appel de la procédure tourdejeu
		end;

	ManchesGagnees(TabJoueur); // Appel de la procédure ManchesGagnees

	ASSIGN(FichierMorpion,'morpion.txt');
	Rewrite(FichierMorpion);
	Append(FichierMorpion);

	PartieGagnee(TabJoueur,FichierMorpion); //Appel de la procédure PartieGagnee
	
	Close(FichierMorpion);

	readln;

END.




