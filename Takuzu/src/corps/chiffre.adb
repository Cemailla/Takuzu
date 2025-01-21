package body Chiffre is

   function ValeurChiffre (C : in Type_Chiffre) return Integer is
   begin
      if Integer(C) = Integer(UN) then
         return 1;
      elsif Integer(C) = Integer(ZERO) then
         return 0;
      else
         return -1;
      end if;
   end ValeurChiffre;

   function EstInconnue (C : in Type_Chiffre) return Boolean is
   begin
      return ValeurChiffre(C) = -1;
   end EstInconnue;

   function Complement (C : in Type_Chiffre) return Type_Chiffre is
   begin
      if not EstInconnue(C) then
         if ValeurChiffre(C) = 1 then
            return ZERO;
         else
            return UN;
         end if;
      else
         raise VALEUR_INCONNUE;
      end if;
   end Complement;

   function "=" (c1 : in Type_Chiffre; c2: in Type_Chiffre) return Boolean is
      a : Integer := ValeurChiffre(c1);
      b : Integer := ValeurChiffre(c2);
   begin
      return a = b;
   end "=";

end Chiffre;
