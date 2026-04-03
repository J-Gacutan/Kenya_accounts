# Madagascar -- Comptabilite ecosystemique SCEE CE : methodologie complete

**Projet :** AFRICA -- accounts / Madagascar
**Cadre :** Systeme de comptabilite economique et environnementale -- Comptabilite des ecosystemes (SCEE CE)
**Type d'ecosysteme :** Recifs coralliens photiques (UICN GET M1.3)
**Zone d'etude :** Barriere recifale du sud-ouest de Madagascar, Morombe a Ambohibola
**Periode comptable :** 2025-2026
**Fournisseurs de donnees :** Programme OASIS-M (Laza, Maka) ; Universite de Toliara / IHSM (Yves Amoros Mitondrasoa)

---

## 1. Introduction

### 1.1 Champ d'application du pilote malgache

Le pilote de Madagascar produit des comptes de condition ecosystemique selon le cadre SCEE CE pour les recifs coralliens photiques (M1.3) le long de la barriere recifale du sud-ouest de Madagascar. C'est le pilote le plus avance du projet AFRICA-accounts, avec des comptes de condition complets sur les poissons et les invertebres, issus de 5 186 releves de poissons par recensement visuel sous-marin (UVC) et de 698 releves d'invertebres et d'oursins sur 27 sites.

### 1.2 Types de comptes

| Compte | Statut | Source de donnees |
|--------|--------|-------------------|
| Condition (poissons + invertebres) | ACHEVE (Etapes 1-7) | Releves de terrain UVC OASIS-M |
| Etendue (cartographie satellite) | EN COURS | Sentinel-2 + validation terrain |
| Service de nourricerie halieutique | PRELIMINAIRE | Biomasse + methode LRR |
| Service d'approvisionnement en poissons | PRELIMINAIRE | Estimations de captures + rente des ressources |

---

## 2. Zone d'etude et plan d'echantillonnage

### 2.1 Reseau de sites

**27 sites** le long de la barriere recifale du sud-ouest de Madagascar, de Morombe (nord) a Ambohibola (sud).

**85 stations de releve**, 2 transects par station = 170 transects au total.

**Profondeur :** 3,6-16,5 m.

### 2.2 Dimensions des transects

| Parametre | Valeur | Statut |
|-----------|--------|--------|
| Longueur du transect | 50 m | Confirme |
| Largeur du transect | 5 m | Confirme |
| Surface du transect | 250 m2 | Confirme avec l'equipe de terrain |

### 2.3 Periodes de releve

| Periode | Sites | Dates | Role |
|---------|-------|-------|------|
| 2025 | 15 sites | Nov 2025 - Jan 2026 | Valeurs d'ouverture |
| 2026 | 12 sites | Jan - Fev 2026 | Valeurs de cloture |

---

## 3. Sources de donnees

### 3.1 Donnees sur les poissons (Fishdata_OASIS_M.xlsx)

- **Releves :** 5 186 lignes
- **Observateur :** Laza
- **Especes :** 227 especes, 39 familles, 100 genres
- **Classes de taille :** 6 intervalles (5-10, 10-20, 20-30, 30-40, 40-50, 50-60 cm)
- **Parametres allometriques :** 124 valeurs uniques de a, 55 valeurs de b

### 3.2 Donnees sur les macroinvertebres (Invertebrate_0ASIS_M.xlsx, Feuille 1)

- **Releves :** 999 bruts, 434 apres controle qualite (565 lignes exclues en raison de champs manquants)
- **Observateur :** Maka
- **Especes :** 59 especes
- **Indicateurs principaux :** Acanthaster (Acanthaster planci), benitier (Tridacna maxima)

### 3.3 Donnees sur les oursins (Invertebrate_0ASIS_M.xlsx, Feuille 2)

- **Releves :** 999 bruts, 264 apres controle qualite
- **Observateurs :** Laza et Maka
- **Especes :** 8 especes d'oursins (Diadema setosum, Echinometra mathaei, etc.)
- **Probleme de qualite :** 36 chaines de formules evaluees (ex. : "=(10*48)" converties en valeurs numeriques)

---

## 4. Indicateurs de biomasse et de communaute de poissons

### 4.1 Calcul de la biomasse

```
Pour chaque poisson observe :
    L = point median de la classe de taille (cm)
        5-10 = 7,5 ; 10-20 = 15 ; 20-30 = 25 ; 30-40 = 35 ; 40-50 = 45 ; 50-60 = 55
    W = a x L^b  (grammes par individu)
    biomasse_g = W x nombre

Par transect :
    biomasse_kg_ha = (somme(biomasse_g) / 1 000) / (SURFACE_TRANSECT_M2 / 10 000)

Par site (moyenne +/- erreur standard) :
    biomasse_moyenne_kg_ha = moyenne(biomasse par transect)
    erreur_standard = ecart_type / racine(n_transects)
```

### 4.2 Indicateurs communautaires

| Indicateur | Calcul | Unite |
|------------|--------|-------|
| Biomasse de poissons | W = a x L^b, mise a l'echelle par hectare | kg/ha |
| Abondance de poissons | Comptage mis a l'echelle par hectare | individus/ha |
| Richesse specifique | Especes uniques par site et par annee | nombre |
| Composition trophique | % de biomasse par groupe fonctionnel | % |

### 4.3 Resultats

| Metrique | 2025 (Ouverture) | 2026 (Cloture) |
|----------|-------------------|----------------|
| Biomasse moyenne | 1 929 kg/ha | 1 775 kg/ha |
| Fourchette de biomasse | 498-4 707 kg/ha | Variable |
| Richesse moyenne | 56 especes | 56 especes |
| Fourchette de richesse | 27-94 especes | 25-103 especes |

---

## 5. Indicateurs d'invertebres

### 5.1 Acanthaster pourpre (COTS)

| Metrique | 2025 | 2026 |
|----------|------|------|
| Sites avec COTS | 3 sur 27 | 0 sur 12 |
| Densite moyenne (zone comptable) | 6,7 ind/ha | 0,0 ind/ha |

### 5.2 Densite d'oursins

- **Densite moyenne :** 1,83 ind/m2 (fourchette 0-15,6)
- **Statut :** NON ENCORE INCLUS dans le compte formel ; niveau de reference provisoire uniquement (1,5-2 ind/m2, confiance FAIBLE)

### 5.3 Benitier (Tridacna maxima)

- **Statut :** Donnees disponibles ; pas encore quantifie en tant qu'indicateur formel
- **Reference provisoire :** 122-141 ind/ha (Lakshadweep, ocean Indien ; confiance FAIBLE-MOYENNE)

---

## 6. Normalisation et niveaux de reference

### 6.1 Niveaux de reference

| Indicateur | Niveau de reference | Type de formule | Confiance | Source |
|------------|---------------------|-----------------|-----------|--------|
| Biomasse de poissons | 1 150 kg/ha (objectif de conservation OIO) | Standard | HAUTE | McClanahan et al. (2016) |
| Richesse specifique | Max observe (103 especes) | Standard (relatif) | MOYENNE | Interne au jeu de donnees |
| Densite d'acanthasters | 15 ind/ha (seuil de pullulation) | Inverse | MOYENNE | Dulvy et al. (2021) |
| Densite d'oursins | 1,75 ind/m2 (provisoire) | Plage optimale | FAIBLE | Kenya/OIO provisoire |

### 6.2 Formules de normalisation

**Standard (valeur elevee = meilleur etat) :**
```
IC = min(valeur mesuree / reference, 1,0)
```

**Inverse (acanthasters ; valeur elevee = mauvais etat) :**
```
IC = max(1 - valeur mesuree / seuil, 0,0)
```

---

## 7. Compte de condition SCEE CE

### 7.1 Resume de la zone comptable

| Variable | Unites | Recif corallien (M1.3) |
|--------|--------|------------------------|
| Biomasse de poissons -- 2025 | indice (0-1) | 1,00 |
| Biomasse de poissons -- 2026 | indice (0-1) | 1,00 |
| Richesse specifique -- 2025 | indice (0-1) | 0,54 |
| Richesse specifique -- 2026 | indice (0-1) | 0,54 |
| Densite COTS -- 2025 | indice (0-1) | 0,55 |
| Densite COTS -- 2026 | indice (0-1) | 1,00 |
| Composite -- 2025 | indice (0-1) | 0,70 |
| Composite -- 2026 | indice (0-1) | 0,85 |

### 7.2 Heterogeneite entre sites

La biomasse varie de 498 kg/ha (Ambatomilo ; IC = 0,43) a 4 707 kg/ha (Ambitiky ; IC = 1,0). Cette variation de 9,4 fois est masquee par la moyenne de la zone comptable. Les tableaux par site sont indispensables pour identifier les sites degrades necessitant une gestion ciblee.

---

## 8. Composition trophique

| Groupe fonctionnel | % biomasse (2025-2026 confondus) |
|---------------------|----------------------------------|
| Herbivore | 40,6 |
| Carnivore | 30,0 |
| Planctivore | 15,2 |
| Corallivore | 8,7 |
| Omnivore | 5,5 |

La dominance des herbivores (41 %) indique une forte capacite de broutage des algues -- un signe positif pour la resilience du recif. L'equilibre trophique avec les carnivores a 30 % suggere une complexite ecosystemique fonctionnelle.

---

## 9. Compte d'etendue (en cours)

**Methode :** Imagerie satellite Sentinel-2 (resolution 10 m) + classification par angle spectral (SAM).

**Fournisseur :** Yves Amoros Mitondrasoa, Universite de Toliara / IHSM.

**Statut :** Classification en cours ; carte de reference initiale attendue pour mars 2026. Etendue estimee : ~12 085 ha de recif (preliminaire).

---

## 10. Comptes de services ecosystemiques

### 10.1 Service de nourricerie halieutique (regulation)

- **Methode :** Rapport de reponse logarithmique (LRR) ; amelioration de 31 % pour les recifs coralliens
- **Production annuelle amelioree :** ~20 362 kg/an
- **Prix du marche :** ~3 $/kg (URGENT : confirmer par enquete de marche locale)
- **Valeur economique annuelle :** ~61 087 $/an (incertitude de +/- 50 %)

### 10.2 Service d'approvisionnement en poissons sauvages

- **Capture annuelle estimee :** ~115 700 kg/an
- **Prix unitaire moyen :** 2,50 $/kg
- **Recettes brutes :** ~289 250 $/an
- **Rente des ressources (benefice net) :** ~87 563 $/an (incertitude de +/- 50 %)

---

## 11. Chaine de controle qualite

```
1. INGESTION : readxl::read_excel() + janitor::clean_names()
2. CORRECTION GPS : Restauration des separateurs decimaux manquants (17 lat, 18 lon)
3. TAXONOMIE : str_to_sentence(espece), str_to_title(famille)
4. GROUPES FONCTIONNELS : 17 variantes brutes harmonisees en 7 categories standard
5. EVALUATION DE FORMULES : 36 chaines de formules dans les donnees d'abondance d'oursins converties en valeurs numeriques
6. FILTRAGE DES VALEURS MANQUANTES : Invertebres 999 -> 434 ; Oursins 999 -> 264
7. CLASSES DE TAILLE : "5_10" -> point median 7,5 cm (6 intervalles)
8. BIOMASSE : W = a x L^b par espece et par classe de taille
9. AGREGATION : Transect -> Site x Annee x Groupe fonctionnel
10. EXPORT : Fichiers CSV avec prefixe MDG_ vers 03_outputs/
```

---

## 12. Fichiers de sortie

Tous dans `Madagascar/03_outputs/` avec le prefixe MDG_ :

| Fichier | Contenu |
|---------|---------|
| MDG_fish_invert_site_condition.csv | Resume par site (27 sites ; biomasse, richesse, COTS, oursins) |
| MDG_fish_invert_site_fg_condition.csv | Ventilation par groupe fonctionnel, site et annee |
| MDG_fish_invert_seea_condition.csv | Tableau SCEE CE de la zone comptable (3 indicateurs x 2 annees) |
| MDG_fish_invert_seea_condition_per_site.csv | Ventilation SCEE CE par site (81 lignes) |
| MDG_fish_invert_condition_account_raw.csv | Valeurs brutes avec ouverture/cloture/variation |
| MDG_fish_invert_condition_account_normalized.csv | IC normalises avec interpretation |

---

## 13. Points en suspens et limites

### 13.1 Points critiques

| Point | Impact |
|-------|--------|
| Surface du transect | Confirmee : 250 m2 (50 m x 5 m) — resolu |
| Les CSV utilisent encore la reference de 500 kg/ha | Re-executer le script avec 1 150 kg/ha et re-exporter |
| Cartographie Sentinel-2 non achevee | Les calculs de services par hectare sont bloques |
| Enquete sur les prix du marche non realisee | Les valorisations de services ne sont que des estimations |

---

## 14. References

Dulvy, N.K., et al. (2021). Seuil de pullulation des acanthasters : 15 ind/ha. *Nature Communications*.

McClanahan, T.R., et al. (2016). Valeurs de reference et reperes mondiaux pour la biomasse des poissons recifaux. *PLOS ONE*. Objectif de conservation OIO : 1 150 kg/ha.

Samoilys, M.A., et al. (2019). Richesse des poissons recifaux de l'OIO : 82-152 especes par transect.

SCEE CE (2021). Systeme de comptabilite economique et environnementale -- Comptabilite des ecosystemes. Nations Unies.

---

*Version : 1.0*
*Date : 2026-03-29*
*Documents complementaires : MDG_GUIDE_ANIMATEUR.md, MDG_FICHE_PARTICIPANT.md*
