package body Coordonnee is

   -- retourne la valeur d'une Coordonnee
   function ConstruireCoordonnees
     (Ligne, Colonne : in Integer) return Type_Coordonnee is
      C : Type_Coordonnee; --Defini C comme une coordonnee
   begin
      C.Ligne := Ligne; --Ligne de C = Ligne appele dans la fonction
      C.Colonne := Colonne; --Colonne de C = Colonne appele dans la fonction
      return C; --retourne la coordonnee C
   end ConstruireCoordonnees;


   -- retourne le numero de la ligne dans lequel se trouve la coordonnee c
      function ObtenirLigne (C : in Type_Coordonnee) return Integer is
      begin
         return C.Ligne; --retourne la ligne de la coordonnee C
      end ObtenirLigne;

   -- retourne le numero de la colonne dans lequel se trouve la coordonnee c
      function ObtenirColonne (C : in Type_Coordonnee) return Integer is
      begin
         return C.Colonne; --retourne la colonne de la coordonnee C
      end ObtenirColonne;

end Coordonnee;
