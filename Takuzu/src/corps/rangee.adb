with Chiffre; use Chiffre;

package body Rangee is

   function ConstruireRangee (T : in Integer) return Type_Rangee is
      R : Type_Rangee;
      cpt : Integer := 1;
   begin
      R.Taille := T;
      while cpt <= T loop
         R := AjouterChiffre(R,cpt,INCONNU);
         cpt := cpt + 1;
      end loop;
      return R;
   end ConstruireRangee;

   function EstVide (R : in Type_Rangee) return Boolean is
      cpt : Integer := 1;
   begin
      while cpt <= R.Taille loop
         if R.R(cpt) /= INCONNU then
            return False;
         end if;
         cpt := cpt + 1;
      end loop;
      return True;
   end EstVide;

   function EstRemplie (R : in Type_Rangee) return Boolean is
      cpt : Integer := 1;
   begin
      while cpt <= R.Taille loop
         if R.R(cpt) = INCONNU then
            return False;
         end if;
         cpt := cpt + 1;
      end loop;
      return True;
   end EstRemplie;

   function Taille (R : in Type_Rangee) return Integer is
   begin
      return R.Taille;
   end Taille;

   function ObtenirChiffre (R : in Type_Rangee; I : in Integer) return Type_Chiffre is
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      else
         return R.R(I);
      end if;
   end ObtenirChiffre;

   function nombreChiffresConnus (R : in Type_Rangee) return Integer is
      res : Integer := 0;
      cpt : Integer := 1;
   begin
      while cpt <= R.Taille loop
         if R.R(cpt) /= INCONNU then
            res := res + 1;
         end if;
         cpt := cpt + 1;
      end loop;
      return res;
   end nombreChiffresConnus;

   function nombreChiffresDeValeur (R : in Type_Rangee; V : in Type_Chiffre) return Integer is
      res : Integer := 0;
      cpt : Integer := 1;
   begin
      while cpt <= R.Taille loop
         if R.R(cpt) = V then
            res := res + 1;
         end if;
         cpt := cpt + 1;
      end loop;
      return res;
   end nombreChiffresDeValeur;

   function chiffreDeDroite (R : in Type_Rangee; I : in Integer) return Type_Chiffre is
   begin
      if I = R.Taille then
         return INCONNU;
      elsif I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      else
         return R.R(I + 1);
      end if;
   end chiffreDeDroite;

   function chiffreDeGauche (R : in Type_Rangee; I : in Integer) return Type_Chiffre is
   begin
      if I = 1 then
         return INCONNU;
      elsif I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      else
         return R.R(I - 1);
      end if;
   end chiffreDeGauche;

  function SontDeuxChiffresDeDroiteEgaux (R : in Type_Rangee; I : in Integer) return Boolean is
   begin
      if I = R.Taille or I = R.Taille - 1 then
         return False;
      elsif I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      elsif (R.R(I + 1) = INCONNU) and (R.R(I + 2) = INCONNU) then
         return False;
      else
         return R.R(I + 1) = R.R(I + 2);
      end if;
   end SontDeuxChiffresDeDroiteEgaux;

   function SontDeuxChiffresDeGaucheEgaux (R : in Type_Rangee; I : in Integer) return Boolean is
   begin
      if I = 1 or I = 2 then
         return False;
      elsif I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      elsif (R.R(I - 1) = INCONNU) and (R.R(I - 2) = INCONNU) then
         return False;
      else
         return R.R(I - 1) = R.R(I - 2);
      end if;
   end SontDeuxChiffresDeGaucheEgaux;

   function AjouterChiffre (R : in Type_Rangee; I : in Integer; C : in Type_Chiffre) return Type_Rangee is
      R2 : Type_Rangee := R;
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      else
         R2.R(I) := C;
      end if;
      return R2;
   end AjouterChiffre;

  function RetirerChiffre (R : in Type_Rangee; I : in Integer) return Type_Rangee is
      R2 : Type_Rangee := R;
   begin
      if I < 1 or I > R.Taille then
         raise TRANCHE_INVALIDE;
      else
         R2.R(I) := INCONNU;
      end if;
      return R2;
   end RetirerChiffre;

end Rangee;
