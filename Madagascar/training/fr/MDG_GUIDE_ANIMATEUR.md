# Elaboration des comptes de condition des recifs coralliens : guide de l'animateur

## SCEE CE Madagascar -- Indicateurs biotiques de poissons et d'invertebres, sud-ouest de Madagascar

---

## Diapositive 1 : Titre

Elaboration des comptes de condition des ecosystemes recifaux coralliens du sud-ouest de Madagascar

Atelier pratique pour transformer les donnees de terrain de recensement visuel sous-marin (UVC) en tableaux de comptes de condition selon le cadre SCEE CE.

Notes de l'animateur : Bienvenue aux participants. Cette session presente les etapes menant des valeurs brutes des indicateurs issus des releves sous-marins aux tableaux finaux des comptes de condition SCEE CE. Madagascar est le pilote le plus avance du projet AFRICA-accounts : 5 186 releves de poissons, 27 sites, 227 especes. A l'issue de cet atelier, les participants seront en mesure d'elaborer un compte de condition pour tout site recifal ou sous-region.

---

## Diapositive 2 : Qu'est-ce qu'un compte de condition ?

Un compte de condition enregistre l'etat d'un ecosysteme a deux moments differents.

Pour chaque indicateur :

1. Mesurer une valeur a l'annee d'ouverture (2025) et a l'annee de cloture (2026).
2. Comparer chaque valeur a un niveau de reference representant un recif en bonne sante.
3. Le rapport donne un indice de condition compris entre 0 et 1.
4. La variation entre les periodes indique si le recif s'ameliore, est stable ou se degrade.

Notes de l'animateur : Souligner que l'indice de condition (IC) est relatif au niveau de reference. Un IC de 0,43 pour la biomasse de poissons signifie que le site possede 43 % de l'objectif de conservation de l'ocean Indien occidental (1 150 kg/ha). L'IC rend comparables des indicateurs dont les unites different -- kg/ha, nombre d'especes, ind/ha -- sur la meme echelle de 0 a 1.

---

## Diapositive 3 : Le jeu de donnees malgache

| Dimension | Valeur |
|-----------|--------|
| Sites | 27 le long du sud-ouest de Madagascar |
| Stations de releve | 85 (2 transects chacune = 170 transects) |
| Releves de poissons | 5 186 |
| Especes de poissons | 227 (39 familles) |
| Releves d'invertebres | 434 (apres controle qualite) |
| Releves d'oursins | 264 (apres controle qualite) |
| Observateur (poissons) | Laza |
| Observateur (invertebres) | Maka |
| Profondeur | 3,6-16,5 m |

Notes de l'animateur : Il s'agit de l'un des plus grands jeux de donnees UVC recifaux dans l'ocean Indien occidental pour la comptabilite ecosystemique SCEE CE. Les 27 sites couvrent toute la barriere recifale du sud-ouest de Madagascar, de Morombe a Ambohibola. Deux periodes de releve (2025 et 2026) permettent la detection de changements entre l'ouverture et la cloture.

---

## Diapositive 4 : Les trois etapes

```
Etape 1 : Donnees brutes --> Controle qualite --> Indicateurs nets par site
          (Le script R gere cette etape : fish_invert_condition.R)

Etape 2 : Indicateurs par site --> Normalisation en IC (0-1) avec niveaux de reference
          (Cet atelier couvre cette etape)

Etape 3 : Agregation par site / zone comptable --> Assemblage du tableau SCEE CE
          (Cet atelier couvre cette etape)
```

Notes de l'animateur : Le script R (962 lignes) gere tout, de l'ingestion des fichiers Excel au calcul de biomasse jusqu'a l'export des fichiers CSV. Cet atelier se concentre sur la comprehension des resultats produits et sur leur interpretation et assemblage dans les tableaux SCEE CE.

---

## Diapositive 5 : La biomasse de poissons -- l'indicateur central

**Comment la biomasse est calculee :**

```
Pour chaque poisson observe :
    L = point median de la classe de taille (ex. : "10-20 cm" = 15 cm)
    W = a x L^b  (grammes ; parametres allometriques de FishBase)
    biomasse_g = W x nombre_d_individus

Par transect (250 m2) :
    biomasse_kg_ha = biomasse_totale_g / 1 000 / 0,025 ha

Par site :
    biomasse moyenne = moyenne des transects
```

Notes de l'animateur : La relation allometrique W = a x L^b convertit la longueur du poisson en poids a l'aide de parametres specifiques a chaque espece. Le jeu de donnees malgache comporte 124 valeurs uniques de a et 55 valeurs de b pour 227 especes. L'approche par point median de la classe de taille introduit de l'incertitude, mais elle est la pratique courante pour les releves UVC. Demandez : "Pourquoi divise-t-on par 0,025 ?" (Parce que 250 m2 = 0,025 ha ; on veut des kg par hectare.)

---

## Diapositive 6 : Formules de normalisation

**Type 1 -- Standard (valeur elevee = meilleur etat) :**

Indice de condition = min(valeur mesuree / niveau de reference, 1,0)

Utilise pour : biomasse de poissons, richesse specifique

**Type 2 -- Inverse (valeur elevee = mauvais etat) :**

Indice de condition = max(1 - valeur mesuree / niveau de reference, 0,0)

Utilise pour : densite d'acanthasters (COTS)

Notes de l'animateur : Ecrivez les deux formules au tableau. Le plafonnement (min a 1,0) est important : la biomasse moyenne a Madagascar est de 1 929 kg/ha, contre un niveau de reference de 1 150 kg/ha. Sans plafonnement, l'IC serait de 1,68. On plafonne a 1,0 car l'IC mesure "la proximite par rapport a l'etat de reference", et non l'ecart au-dessus de celui-ci.

---

## Diapositive 7 : Niveaux de reference

| Indicateur | Niveau de reference | Source | Confiance |
|------------|---------------------|--------|-----------|
| Biomasse de poissons | 1 150 kg/ha | McClanahan et al. (2016) -- Objectif de conservation OIO | HAUTE |
| Richesse specifique | 103 especes (max observe) | Interne au jeu de donnees | MOYENNE |
| Densite d'acanthasters (COTS) | 15 ind/ha (seuil de pullulation) | Dulvy et al. (2021) | MOYENNE |
| Densite d'oursins | 1,75 ind/m2 (provisoire) | Etudes Kenya/OIO | FAIBLE |

Notes de l'animateur : Le niveau de reference de 1 150 kg/ha pour la biomasse de poissons provient d'une etude couvrant 15 pays de l'ocean Indien occidental. Il represente l'objectif de conservation -- le niveau de biomasse necessaire au maintien des fonctions ecosystemiques recifales. Un seuil de durabilite de 600 kg/ha existe, en dessous duquel l'effondrement halieutique est probable. Demandez : "Si l'on utilisait 600 kg/ha comme reference au lieu de 1 150, comment l'IC changerait-il pour un site a 900 kg/ha de biomasse ?" (IC = 900/600 = 1,0 au lieu de 900/1150 = 0,78.)

---

## Diapositive 8 : Exemple guide -- biomasse de poissons

Site : Ambatomilo, 2025. Le site ayant la biomasse la plus faible.

Biomasse moyenne = 498 kg/ha. Reference = 1 150 kg/ha.

IC = min(498 / 1 150, 1,0) = min(0,433, 1,0) = 0,43

Ce site possede 43 % de la biomasse cible de conservation de l'OIO.

Comparaison : Ambitiky, 2025. Le site ayant la biomasse la plus elevee.

Biomasse moyenne = 4 707 kg/ha. Reference = 1 150 kg/ha.

IC = min(4 707 / 1 150, 1,0) = min(4,093, 1,0) = 1,00

Notes de l'animateur : Demandez aux participants de calculer les deux. L'ecart de 9,4 fois entre le site le plus faible et le plus fort (498 contre 4 707 kg/ha) montre une heterogeneite considerable entre sites -- mais les deux sont ramenes a une echelle de 0 a 1.

---

## Diapositive 9 : Exemple guide -- densite d'acanthasters (indicateur inverse)

Site : Anakao, 2025. L'un des 3 sites ou des acanthasters ont ete observees.

Observe : 1 individu d'acanthaster sur un transect de 250 m2. Extrapole : 40 ind/ha.

Probleme : cette extrapolation semble extremement elevee pour 1 seul individu.

C'est le **probleme de sensibilite a l'extrapolation** : 1 individu / 0,025 ha = 40 ind/ha, bien au-dessus du seuil de pullulation de 15 ind/ha. IC = max(1 - 40/15, 0) = 0.

Notes de l'animateur : Developper soigneusement ce point. La moyenne de la zone comptable est plus raisonnable car elle integre 24 sites a zero acanthasters. L'IC a l'echelle de la zone comptable est plus pertinent pour les politiques publiques que les IC par site, fondes sur 1 ou 2 individus seulement.

---

## Diapositive 10 : Composition trophique

| Groupe fonctionnel | % biomasse |
|---------------------|-----------|
| Herbivore | 40,6 |
| Carnivore | 30,0 |
| Planctivore | 15,2 |
| Corallivore | 8,7 |
| Omnivore | 5,5 |

Notes de l'animateur : La composition trophique n'est pas normalisee en IC car il n'existe pas de composition "de reference" unique. La dominance des herbivores (41 %) indique une forte capacite de broutage des algues -- essentielle a la resilience du recif apres un episode de blanchissement. La part des carnivores (30 %) traduit une dynamique predateur-proie fonctionnelle.

---

## Diapositive 11 : Tableau du compte de condition SCEE CE

| Indicateur | 2025 (Ouverture) | 2026 (Cloture) | Variation |
|------------|-------------------|----------------|-----------|
| IC biomasse de poissons | 1,00 | 1,00 | 0,00 |
| IC richesse specifique | 0,54 | 0,54 | 0,00 |
| IC densite de COTS | 0,55 | 1,00 | +0,45 |
| IC composite | 0,70 | 0,85 | +0,15 |

Notes de l'animateur : Le composite s'est ameliore de 0,70 a 0,85, entierement grace a la densite d'acanthasters (passee de 6,7 ind/ha a 0 ind/ha). La biomasse et la richesse specifique sont restees stables. L'amelioration des COTS ne reflete probablement pas un changement ecologique reel mais plutot la variabilite naturelle d'une population a tres faible effectif (seulement 1 a 2 individus sur 3 sites).

---

## Diapositive 12 : Heterogeneite entre sites

La moyenne de la zone comptable masque une variation considerable :

| Site | Biomasse (kg/ha) | IC | Richesse | IC |
|------|-----------------|-----|----------|-----|
| Ambitiky | 4 707 | 1,00 | 52 | 0,50 |
| Andavadoaky | 1 891 | 1,00 | 82 | 0,80 |
| Befasy | 635 | 0,55 | 33 | 0,32 |
| Ambatomilo | 498 | 0,43 | 36 | 0,35 |

Notes de l'animateur : La ventilation par site est indispensable. Ambatomilo (IC = 0,43) necessite une gestion differente d'Ambitiky (IC = 1,0). Le cadre SCEE CE permet les deux niveaux de rapport : le resume de la zone comptable fournit la valeur de synthese, et le tableau par site identifie les priorites.

---

## Diapositive 13 : Surface du transect — confirmee

**Resolu :** La surface du transect est de 250 m2 (50 m x 5 m), confirmee avec l'equipe de terrain.

---

## Diapositive 14 : Exercice -- compte de condition par site

Vous allez elaborer un compte de condition pour 3 sites recifaux malgaches a partir de donnees reelles.

Vous disposez de :
1. Une fiche imprimee avec les formules et les niveaux de reference.
2. Les donnees par site issues de MDG_fish_invert_site_condition.csv (pre-chargees dans Excel).

**Consigne :**
1. Choisissez 3 sites (un a forte biomasse, un moyen, un faible).
2. Calculez l'IC pour la biomasse, la richesse et la densite de COTS.
3. Calculez l'IC composite (moyenne non ponderee des 3 indicateurs).
4. Comparez : quel site est en meilleure condition ? Lequel en moins bonne condition ?

Duree : 35 minutes.

Notes de l'animateur : Circulez pendant l'exercice. Erreurs frequentes : (a) oublier d'inverser les COTS, (b) utiliser la reference de 500 kg/ha au lieu de 1 150 kg/ha (l'ancienne valeur figure encore dans certains CSV), (c) ne pas plafonner a 1,0.

---

## Diapositive 15 : Exercice -- agregation a la zone comptable

A partir de l'ensemble des sites 2025 :

1. Calculez la biomasse moyenne de la zone comptable.
2. Calculez l'IC correspondant.
3. Comparez : l'IC de la zone comptable est-il identique a la moyenne des IC par site ?

Duree : 20 minutes.

Notes de l'animateur : Subtilite importante : l'IC calcule a partir de la biomasse moyenne n'est PAS identique a la moyenne des IC par site (car le plafonnement min() est une operation non lineaire). Les deux approches sont valables mais donnent des resultats differents. La norme SCEE CE calcule l'IC a partir de la valeur moyenne de l'indicateur a l'echelle de la zone comptable.

---

## Diapositive 16 : Exercice -- composition trophique

A partir de MDG_fish_invert_site_fg_condition.csv :

1. Choisissez un site et calculez le pourcentage de biomasse par groupe fonctionnel.
2. Comparez avec la composition de la zone comptable (diapositive 10).
3. Discussion : votre site presente-t-il un equilibre trophique sain ?

Duree : 15 minutes.

---

## Diapositive 17 : Bilan et discussion

Questions :

1. La biomasse moyenne a Madagascar (1 929 kg/ha) depasse la reference OIO (1 150 kg/ha). Tous les recifs sont-ils pour autant en bonne sante ?
2. Seulement 3 des 27 sites possedaient des acanthasters. L'indicateur COTS est-il utile a un niveau de prevalence aussi faible ?
3. Comment l'incertitude sur la surface du transect (100 contre 400 m2) affecte-t-elle votre confiance dans le compte ?
4. Quelles donnees supplementaires permettraient de passer ce compte du Tier 2 au Tier 3 (niveaux de qualite SCEE) ?

---

## Diapositive 18 : Lien entre condition et services ecosystemiques

```
Compte de condition              Compte de service
Biomasse de poissons (kg/ha) --> Nourricerie : production amelioree via LRR (31 %)
                                 ~61 000 $/an (preliminaire)
Biomasse + captures          --> Approvisionnement : rente des ressources halieutiques
                                 ~88 000 $/an (preliminaire)
Richesse specifique          --> Recreation : indicateur d'attractivite touristique
Etendue du recif (ha)        --> Tous les services necessitent l'etendue pour la mise a l'echelle
```

---

## Diapositive 19 : Perspectives

Prochaines etapes pour les comptes SCEE CE de Madagascar :

1. **Confirmer la surface du transect** avec Laza/Maka -- HAUTE PRIORITE
2. **Re-exporter les CSV** avec la reference de 1 150 kg/ha
3. **Achever la cartographie d'etendue Sentinel-2** (mars 2026)
4. **Enquete sur les prix du marche** a Anakao, Ifaty, Salary, Toliara (mars-avril 2026)
5. **Stratification par aire protegee** -- comparer la condition recifale protegee et non protegee
6. **Comptes de services ecosystemiques** -- nourricerie + approvisionnement avec prix et etendue reels

---

## Annexe A : Liste de preparation de l'animateur

### Minutage indicatif

| Diapositives | Contenu | Duree |
|--------------|---------|-------|
| 1-4 | Introduction, donnees, etapes | 25 min |
| 5-7 | Calcul de biomasse, formules, niveaux de reference | 30 min |
| 8-10 | Exemples guides (biomasse, COTS, trophique) | 30 min |
| 11-13 | Tableau SCEE CE, heterogeneite, surface du transect | 20 min |
| -- | Pause | 15 min |
| 14 | Exercice : compte par site | 35 min |
| 15 | Exercice : agregation zone comptable | 20 min |
| 16 | Exercice : composition trophique | 15 min |
| 17 | Bilan et discussion | 25 min |
| 18-19 | Services et perspectives | 15 min |
| -- | **Total** | **~4 heures (demi-journee avec pause)** |

---

## Annexe B : Corrige des exercices

### Exercice 1 : IC par site

| Site | Biomasse (kg/ha) | IC biomasse | Richesse | IC richesse | COTS (ind/ha) | IC COTS | Composite |
|------|-----------------|-------------|----------|-------------|---------------|---------|-----------|
| Ambitiky | 4 707 | 1,00 | 52 | 0,50 | 0 | 1,00 | 0,84 |
| Befasy | 635 | 0,55 | 33 | 0,32 | 0 | 1,00 | 0,62 |
| Ambatomilo | 498 | 0,43 | 36 | 0,35 | 0 | 1,00 | 0,59 |

---

## Annexe C : Questions frequentes

**Q : Pourquoi l'IC de biomasse est-il de 1,0 pour autant de sites ?**
R : La reference OIO (1 150 kg/ha) est un objectif de conservation, non un etat pristine. De nombreux sites du sud-ouest de Madagascar depassent ce seuil, ce qui constitue une bonne nouvelle sur le plan ecologique.

**Q : Pourquoi seulement 3 indicateurs dans le compte malgache ?**
R : Les donnees de couverture benthique, de sante corallienne et de recrutement ne sont pas encore disponibles. Le pilote malgache se concentre sur la condition biotique des poissons et des invertebres. Des indicateurs supplementaires seront ajoutes lorsque la cartographie benthique sera integree.

**Q : Peut-on utiliser cette methodologie pour les poissons d'eau douce ?**
R : Le calcul de biomasse (W = a x L^b) et la normalisation en IC sont universels. Il faut des parametres allometriques specifiques aux especes d'eau douce (depuis FishBase) et des niveaux de reference adaptes a votre type d'ecosysteme.

---

*Version : 1.0*
*Date : 2026-03-29*
*Documents complementaires : MDG_METHODOLOGIE_SCEE_CE.md, MDG_FICHE_PARTICIPANT.md*
