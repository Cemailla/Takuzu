with Grille;     use Grille;
with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;
with Affichage;  use Affichage;
with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Resolution_Takuzu is

   procedure TestGaucheLigne (G : in out Type_Grille; L : in Integer; modif : in out Integer) is
      cpt : Integer := 1;
      C : Type_Coordonnee;
      C2 : Type_Coordonnee;
   begin
      while cpt < Taille(G) - 1 loop
         C := ConstruireCoordonnees(L,cpt);
         C2 := ConstruireCoordonnees(L,cpt + 1);
         if estCaseVide(G,C) then
            if SontDeuxChiffresDeDroiteEgaux(extraireLigne(G,L),cpt) then
               G := FixerChiffre(G,C,Complement(ObtenirChiffre(G,C2)));
               modif := modif + 1;
            end if;
         end if;
         cpt := cpt + 1;
      end loop;
   end TestGaucheLigne;

   procedure TestDroiteLigne (G : in out Type_Grille; L : in Integer; modif : in out Integer) is
      cpt : Integer := Taille(G);
      C : Type_Coordonnee;
      C2 : Type_Coordonnee;
   begin
      while cpt > 2 loop
         C := ConstruireCoordonnees(L,cpt);
         C2 := ConstruireCoordonnees(L,cpt - 1);
         if estCaseVide(G,C) then
            if SontDeuxChiffresDeGaucheEgaux(extraireLigne(G,L),cpt) then
               G := FixerChiffre(G,C,Complement(ObtenirChiffre(G,C2)));
               modif := modif + 1;
            end if;
         end if;
         cpt := cpt - 1;
      end loop;
   end TestDroiteLigne;

   procedure TestHautColonne (G : in out Type_Grille; Col : in Integer; modif : in out Integer) is
      cpt : Integer := 1;
      C : Type_Coordonnee;
      C2 : Type_Coordonnee;
   begin
      while cpt < Taille(G) - 1 loop
         C := ConstruireCoordonnees(cpt,Col);
         C2 := ConstruireCoordonnees(cpt + 1, Col);
         if estCaseVide(G,C) then
            if SontDeuxChiffresDeDroiteEgaux(extraireColonne(G,Col),cpt) then
               G := FixerChiffre(G,C,Complement(ObtenirChiffre(G,C2)));
               modif := modif + 1;
            end if;
         end if;
         cpt := cpt + 1;
      end loop;
   end TestHautColonne;

   procedure TestBasColonne (G : in out Type_Grille; Col : in Integer; modif : in out Integer) is
      cpt : Integer := Taille(G);
      C : Type_Coordonnee;
      C2 : Type_Coordonnee;
   begin
      while cpt > 2 loop
         C := ConstruireCoordonnees(cpt,Col);
         C2 := ConstruireCoordonnees(cpt - 1,Col);
         if estCaseVide(G,C) then
            if SontDeuxChiffresDeGaucheEgaux(extraireColonne(G,Col),cpt) then
               G := FixerChiffre(G,C,Complement(ObtenirChiffre(G,C2)));
               modif := modif + 1;
            end if;
         end if;
         cpt := cpt - 1;
      end loop;
   end TestBasColonne;

   procedure TestLigne (G : in out Type_Grille; L : in Integer; modif : in out Integer) is
      cpt : Integer := 2;
      C : Type_Coordonnee;
      C2 : Type_Coordonnee;
   begin
      while cpt < Taille(G) loop
         C := ConstruireCoordonnees(L,cpt);
         C2 := ConstruireCoordonnees(L,cpt - 1);
         if estCaseVide(G,C) and (not estCaseVide(G,C2)) then
            if chiffreDeDroite(extraireLigne(G,L),cpt) = chiffreDeGauche(extraireLigne(G,L),cpt) then
               G := FixerChiffre(G,C,Complement(chiffreDeDroite(extraireLigne(G,L),cpt)));
               modif := modif + 1;
            end if;
         end if;
         cpt := cpt + 1;
      end loop;
   end TestLigne;

   procedure TestColonne (G : in out Type_Grille; Col : in Integer; modif : in out Integer) is
      cpt : Integer := 2;
      C : Type_Coordonnee;
      C2 : Type_Coordonnee;
   begin
      while cpt < Taille(G) loop
         C := ConstruireCoordonnees(cpt,Col);
         C2 := ConstruireCoordonnees(cpt - 1,Col);
         if estCaseVide(G,C) and (not estCaseVide(G,C2)) then
            if chiffreDeDroite(extraireColonne(G,Col),cpt) = chiffreDeGauche(extraireColonne(G,Col),cpt) then
               G := FixerChiffre(G,C,Complement(chiffreDeDroite(extraireColonne(G,Col),cpt)));
               modif := modif + 1;
            end if;
         end if;
         cpt := cpt + 1;
      end loop;
   end TestColonne;

   procedure CompleterLigne (G : in out Type_Grille; L : in Integer; V : in Type_Chiffre; modif : in out Integer) is
      cpt : Integer := 1;
      C : Type_Coordonnee;
   begin
      while cpt <= Taille(G) loop
         C := ConstruireCoordonnees(L,cpt);
         if estCaseVide(G,C) then
            G := FixerChiffre(G,C,V);
            modif := modif + 1;
         end if;
         cpt := cpt + 1;
      end loop;
   end CompleterLigne;

   procedure CompleterColonne (G : in out Type_Grille; Col : in Integer; V : in Type_Chiffre; modif : in out Integer) is
      cpt : Integer := 1;
      C : Type_Coordonnee;
   begin
      while cpt <= Taille(G) loop
         C := ConstruireCoordonnees(cpt,Col);
         if estCaseVide(G,C) then
            G := FixerChiffre(G,C,V);
            modif := modif + 1;
         end if;
         cpt := cpt + 1;
      end loop;
   end CompleterColonne;

   function VerifierTest (G : in Type_Grille) return Boolean is
      cpt : Integer := 1;
      cpt2 : Integer;
      R : Type_Rangee;
   begin
      if not EstRemplie(G) then
         return False;
      else
         while cpt <= Taille(G) loop
            if nombreChiffresDeValeur(extraireLigne(G,cpt),UN) /= nombreChiffresDeValeur(extraireLigne(G,cpt),ZERO) then
               return False;
            elsif nombreChiffresDeValeur(extraireColonne(G,cpt),UN) /= nombreChiffresDeValeur(extraireColonne(G,cpt),ZERO) then
               return False;
            end if;
            cpt := cpt + 1;
         end loop;
         cpt := 1;
         while cpt <= Taille(G) loop
            R := extraireColonne(G,cpt);
            cpt2 := 1;
            while cpt2 <= Taille(G) - 2 loop
               if SontDeuxChiffresDeDroiteEgaux(R,cpt2) and (ObtenirChiffre(R,cpt2) = ObtenirChiffre(R,cpt2 + 1)) then
                  return False;
               end if;
               cpt2 := cpt2 + 1;
            end loop;
            R := extraireligne(G,cpt);
            cpt2 := 1;
            while cpt2 <= Taille(G) - 2 loop
               if SontDeuxChiffresDeDroiteEgaux(R,cpt2) and (ObtenirChiffre(R,cpt2) = ObtenirChiffre(R,cpt2 + 1)) then
                  return False;
               end if;
               cpt2 := cpt2 + 1;
            end loop;
            cpt := cpt + 1;
         end loop;
      end if;
      return True;
   end VerifierTest;


   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean) is

      cptmodif : Integer;
      cpt : Integer;
      cpt1 : Integer;
      cpt2 : Integer := 0;
      GTest : Type_Grille;
      CTest : Type_Coordonnee;
      TrouveTest : Boolean;

   begin
      Trouve := False;
      while (not Trouve) and cpt2 <= 3 loop
         cptmodif := 0;
         cpt := 1;
         while cpt <= Taille(G) loop
            TestGaucheLigne(G,cpt,cptmodif);
            TestDroiteLigne(G,cpt,cptmodif);
            TestHautColonne(G,cpt,cptmodif);
            TestBasColonne(G,cpt,cptmodif);
            cpt := cpt + 1;
         end loop;
         if cptmodif = 0 then
            cpt := 1;
            while cpt <= Taille(G) loop
               TestLigne(G,cpt,cptmodif);
               TestColonne(G,cpt,cptmodif);
               cpt := cpt + 1;
            end loop;
            if cptmodif = 0 then
               cpt := 1;
               while cpt <= Taille(G) loop
                  if (nombreChiffresDeValeur(extraireLigne(G,cpt),UN) = Taille(G) / 2) and not EstRemplie(extraireLigne(G,cpt)) then
                     CompleterLigne(G,cpt,ZERO,cptmodif);
                  elsif (nombreChiffresDeValeur(extraireLigne(G,cpt),ZERO) = Taille(G) / 2) and not EstRemplie(extraireLigne(G,cpt)) then
                     CompleterLigne(G,cpt,UN,cptmodif);
                  elsif (nombreChiffresDeValeur(extraireColonne(G,cpt),UN) = Taille(G) / 2) and not EstRemplie(extraireColonne(G,cpt)) then
                     CompleterColonne(G,cpt,ZERO,cptmodif);
                  elsif (nombreChiffresDeValeur(extraireColonne(G,cpt),ZERO) = Taille(G) / 2) and not EstRemplie(extraireColonne(G,cpt)) then
                     CompleterColonne(G,cpt,UN,cptmodif);
                  end if;
                  cpt := cpt + 1;
               end loop;
               if cpt2 > 1 and cptmodif = 0 then
                  cpt := 1;
                  while cpt <= Taille(G) loop
                     cpt1 := 1;
                     while cpt1 <= Taille(G) loop
                        if estCaseVide(G,ConstruireCoordonnees(cpt,cpt1)) then
                           CTest := ConstruireCoordonnees(cpt,cpt1);
                        end if;
                        cpt1 := cpt1 + 1;
                     end loop;
                     cpt := cpt + 1;
                  end loop;
                  GTest := FixerChiffre(G,CTest,UN);
                  TrouveTest := False;
                  ResoudreTakuzu(GTest,TrouveTest);
                  if VerifierTest(GTest) and TrouveTest then
                     G := GTest;
                     Trouve := True;
                  else
                     GTest := FixerChiffre(G,CTest,ZERO);
                     TrouveTest := False;
                     ResoudreTakuzu(GTest,TrouveTest);
                     if VerifierTest(GTest) and TrouveTest then
                        G := GTest;
                        Trouve := True;
                     else
                        cpt2 := cpt2 + 1;
                     end if;
                  end if;
               elsif cptmodif = 0 then
                  cpt2 := cpt2 + 1;
               else
                  cpt2 := 0;
               end if;
            else
               cpt2 := 0;
            end if;
         else
            cpt2 := 0;
         end if;
         if EstRemplie(G) then
            if VerifierTest(G) then
               Trouve := True;
            else
               cpt2 := 9;
            end if;
         end if;
      end loop;
      if VerifierTest(G) then
         AfficherGrille(G);
      end if;
   end ResoudreTakuzu;
end Resolution_Takuzu;
