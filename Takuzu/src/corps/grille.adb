with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;

package body Grille is

   function ConstruireGrille (T : Integer) return Type_Grille is
      Gril : Type_Grille;
      cpt1 : Integer := 1;
      cpt2 : Integer := 1;
      C : Type_Coordonnee;
   begin
      if (T >= 4) and (T mod 2 = 0) then
         Gril.Taille := T;
         while cpt1 <= Gril.Taille loop
            while cpt2 <= Gril.Taille loop
               C := ConstruireCoordonnees(cpt1,cpt2);
               Gril.G(ObtenirLigne(C),ObtenirColonne(C)) := INCONNU;
               cpt2 := cpt2 + 1;
            end loop;
            cpt2 := 1;
            cpt1 := cpt1 + 1;
         end loop;
      else
         raise TAILLE_GRILLE_INVALIDE;
      end if;
      return Gril;
   end ConstruireGrille;

   function Taille (G : in Type_Grille) return Integer is
   begin
      return G.Taille;
   end Taille;

   function estCaseVide (G : in Type_Grille; C : in Type_Coordonnee) return Boolean is
   begin
      return EstInconnue(G.G(ObtenirLigne(C),ObtenirColonne(C)));
   end estCaseVide;

   function ObtenirChiffre (G : in Type_Grille; C : in Type_Coordonnee) return Type_Chiffre is
   begin
      if estCaseVide(G,C) then
         raise CASE_VIDE;
      else
         return G.G(ObtenirLigne(C),ObtenirColonne(C));
      end if;
   end ObtenirChiffre;

   function NombreChiffresConnus (G : in Type_Grille) return Integer is
      res : Integer := G.Taille * G.Taille;
      cpt1 : Integer := 1;
      cpt2 : Integer := 1;
      C : Type_Coordonnee;
   begin
      while cpt1 <= G.Taille loop
         while cpt2 <= G.Taille loop
            C := ConstruireCoordonnees(cpt1,cpt2);
            if estCaseVide(G,C) then
               res := res - 1;
            end if;
            cpt2 := cpt2 + 1;
         end loop;
         cpt2 := 1;
         cpt1 := cpt1 + 1;
      end loop;
      return res;
   end NombreChiffresConnus;

   function EstRemplie (G : in Type_Grille) return Boolean is
   begin
      return NombreChiffresConnus(G) = Taille(G) * Taille(G);
   end EstRemplie;

   function extraireLigne (G : in Type_Grille; L : in Integer) return Type_Rangee is
      R : Type_Rangee := ConstruireRangee(G.Taille);
      cpt : Integer := 1;
   begin
      while cpt <= G.Taille loop
         R := AjouterChiffre(R,cpt,G.G(L,cpt));
         cpt := cpt + 1;
      end loop;
      return R;
   end extraireLigne;

   function extraireColonne (G : in Type_Grille; C : in Integer) return Type_Rangee is
      R : Type_Rangee := ConstruireRangee(G.Taille);
      cpt : Integer := 1;
   begin
      while cpt <= G.Taille loop
         R := AjouterChiffre(R,cpt,G.G(cpt,C));
         cpt := cpt + 1;
      end loop;
      return R;
   end extraireColonne;

   function FixerChiffre (G : in Type_Grille; C : in Type_Coordonnee; V : in Type_Chiffre) return Type_Grille is
      G2 : Type_Grille := ConstruireGrille(G.Taille);
   begin
      if not estCaseVide(G,C) then
         raise FIXER_CHIFFRE_NON_NUL;
      else
         G2 := G;
         G2.G(ObtenirLigne(C),ObtenirColonne(C)) := V;
      end if;
      return G2;
   end FixerChiffre;

   function ViderCase (G : in Type_Grille; C : in Type_Coordonnee) return Type_Grille is
      G2 : Type_Grille := ConstruireGrille(G.Taille);
   begin
      if estCaseVide(G,C) then
         raise VIDER_CASE_VIDE;
      else
         G2 := G;
         G2.G(ObtenirLigne(C),ObtenirColonne(C)) := INCONNU;
      end if;
      return G2;
   end ViderCase;

end Grille;
