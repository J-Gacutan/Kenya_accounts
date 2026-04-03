# Fiche du participant : Elaboration des comptes de condition des recifs coralliens

## Atelier SCEE CE Madagascar -- Barriere recifale du sud-ouest de Madagascar

---

## Formules de normalisation

### Type 1 -- Standard (valeur elevee = meilleur etat)
```
IC = min(valeur mesuree / reference, 1,0)
```
Utilise pour : biomasse de poissons (ref. : 1 150 kg/ha), richesse specifique (ref. : max observe)

### Type 2 -- Inverse (valeur elevee = mauvais etat)
```
IC = max(1 - valeur mesuree / reference, 0,0)
```
Utilise pour : densite d'acanthasters (ref. : 15 ind/ha, seuil de pullulation)

### Composite
```
IC composite = moyenne(IC_biomasse, IC_richesse, IC_COTS)
```

---

## Niveaux de reference

| Indicateur | Reference | Formule | Confiance |
|------------|-----------|---------|-----------|
| Biomasse de poissons | 1 150 kg/ha | Standard | HAUTE |
| Richesse specifique | 103 especes (max observe) | Standard | MOYENNE |
| Densite d'acanthasters (COTS) | 15 ind/ha (pullulation) | Inverse | MOYENNE |
| Densite d'oursins | 1,75 ind/m2 (provisoire) | Plage optimale | FAIBLE |

---

## Aide-memoire : calcul de la biomasse

```
W = a x L^b  (grammes par poisson)

Points medians des classes de taille :
    5-10 cm  = 7,5 cm
    10-20 cm = 15 cm
    20-30 cm = 25 cm
    30-40 cm = 35 cm
    40-50 cm = 45 cm
    50-60 cm = 55 cm

Conversion par hectare :
    biomasse_kg_ha = (somme des biomasse_g) / 1 000 / (surface_transect_m2 / 10 000)
    Si transect = 250 m2 : diviser par 0,025 ha
```

---

## Exercice 1 : Compte de condition par site (35 minutes)

Choisissez 3 sites dans MDG_fish_invert_site_condition.csv.

**Site 1 :** _________________________

| Indicateur | Valeur mesuree | Reference | Formule | IC |
|------------|----------------|-----------|---------|-----|
| Biomasse (kg/ha) | | 1 150 | Standard | |
| Richesse specifique | | 103 | Standard | |
| Densite COTS (ind/ha) | | 15 | Inverse | |
| **Composite** | | | Moyenne | |

**Site 2 :** _________________________

| Indicateur | Valeur mesuree | Reference | Formule | IC |
|------------|----------------|-----------|---------|-----|
| Biomasse (kg/ha) | | 1 150 | Standard | |
| Richesse specifique | | 103 | Standard | |
| Densite COTS (ind/ha) | | 15 | Inverse | |
| **Composite** | | | Moyenne | |

**Site 3 :** _________________________

| Indicateur | Valeur mesuree | Reference | Formule | IC |
|------------|----------------|-----------|---------|-----|
| Biomasse (kg/ha) | | 1 150 | Standard | |
| Richesse specifique | | 103 | Standard | |
| Densite COTS (ind/ha) | | 15 | Inverse | |
| **Composite** | | | Moyenne | |

**Questions :**
a. Quel site a l'IC composite le plus eleve ?
b. Quel indicateur montre la plus grande variation entre vos 3 sites ?
c. Si la surface du transect etait de 100 m2 au lieu des 250 m2 confirmes, comment l'IC de biomasse changerait-il ?

---

## Exercice 2 : Agregation a la zone comptable (20 minutes)

A partir de l'ensemble des sites 2025, calculez la moyenne de la zone comptable pour chaque indicateur, puis l'IC.

| Indicateur | Moyenne zone comptable | Reference | IC |
|------------|------------------------|-----------|-----|
| Biomasse (kg/ha) | | 1 150 | |
| Richesse specifique | | 103 | |
| Densite COTS (ind/ha) | | 15 | |
| **Composite** | | | |

---

## Exercice 3 : Composition trophique (15 minutes)

Choisissez un site dans MDG_fish_invert_site_fg_condition.csv.

**Site :** _________________________

| Groupe fonctionnel | Biomasse (kg/ha) | % du total |
|---------------------|-----------------|-----------|
| Herbivore | | |
| Carnivore | | |
| Planctivore | | |
| Corallivore | | |
| Omnivore | | |
| Autre | | |
| **Total** | | 100 % |

La composition trophique est-elle equilibree ? La dominance des herbivores traduit-elle un bon controle des algues ?

---

## Modele de tableau SCEE CE

| Ecosysteme | Indicateur | Annee | Valeur mesuree | Unite | IC | Reference | Confiance | Note |
|------------|-----------|-------|----------------|-------|-----|-----------|-----------|------|
| M1.3 | | | | | | | | |
| M1.3 | | | | | | | | |
| M1.3 | | | | | | | | |

---

*Supports d'atelier : Elaboration des comptes de condition des recifs coralliens du sud-ouest de Madagascar*
*Date : _______________ | Participant : _______________*
