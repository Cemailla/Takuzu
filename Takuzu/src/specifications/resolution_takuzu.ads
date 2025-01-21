with Grille;     use Grille;
with Coordonnee; use Coordonnee;
with Chiffre;    use Chiffre;
with Rangee;     use Rangee;

package Resolution_Takuzu is

   -- v�rifie de gauche a droite la regle 1 du jeu, et rempli la ligne
   procedure TestGaucheLigne (G : in out Type_Grille; L : in Integer; modif : in out Integer);

   -- v�rifie de droite a gauche la regle 1 du jeu, et rempli la ligne
   procedure TestDroiteLigne (G : in out Type_Grille; L : in Integer; modif : in out Integer);

   -- v�rifie de haut en bas la regle 1 du jeu, et rempli la colonne
   procedure TestHautColonne (G : in out Type_Grille; Col : in Integer; modif : in out Integer);

   -- v�rifie de bas en haut la regle 1 du jeu, et rempli la colonne
   procedure TestBasColonne (G : in out Type_Grille; Col : in Integer; modif : in out Integer);

   -- v�rifie sur une ligne le cas de figure V - V
   procedure TestLigne (G : in out Type_Grille; L : in Integer; modif : in out Integer);

   -- v�rifie sur une colonne le cas de figure V - V
   procedure TestColonne (G : in out Type_Grille; Col : in Integer; modif : in out Integer);

   -- Règle 1 : complète la lignes l qui ont déjà 4 UN ou 4 ZERO
   procedure CompleterLigne
     (G : in out Type_Grille; L : in Integer; V : in Type_Chiffre; modif : in out Integer);

   -- Règle 1 : complète les colonnes qui ont déjà 4 UN ou 4 ZERO
   procedure CompleterColonne
     (G : in out Type_Grille; Col : in Integer; V : in Type_Chiffre; modif : in out Integer);

   function VerifierTest (G : in Type_Grille) return Boolean;

   -- si la solution a ete trouve pour la grille g, alors Trouve est a VRAI et
   -- la grille est complete sinon Trouve est a FAUX et la grille n'a aucune
   -- valeur significative parcours la grille
   procedure ResoudreTakuzu (G : in out Type_Grille; Trouve : out Boolean);

end Resolution_Takuzu;
