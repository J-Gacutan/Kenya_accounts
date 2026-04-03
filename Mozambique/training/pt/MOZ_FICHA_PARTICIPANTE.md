# Ficha do Participante: Elaboracao de Contas de Ecossistemas de Mangal a partir de Deteccao Remota

## Oficina SCEE CE Mocambique -- Estuario do Save e Estuario de Morrumbene

---

## Formula de Normalizacao

### Reescalonamento Linear (degradado-a-pristino)

```
IC = limitar((observado - degradado) / (pristino - degradado), 0, 1)

Se resultado < 0: definir IC = 0
Se resultado > 1: definir IC = 1
```

### Indice de Condicao Composto

```
ICC = media(IC_altura, IC_cobertura, IC_agbd, IC_iaf)
```

### Agregacao Ponderada pela Area ao Nivel do Local

```
ICC_local = soma(ICC_i x area_ha_i) / soma(area_ha_i)
```

### Stock de Carbono

```
Carbono total (Mg C) = densidade_carbono (Mg C/ha) x area (ha)
Equivalente CO2 (Mg CO2) = carbono total x 3,664
```

---

## Niveis de Referencia

| Indicador | Variavel GEDI | Unidade | Degradado (IC=0) | Pristino (IC=1) | Confianca |
|-----------|--------------|---------|------------------|-----------------|-----------|
| Altura do copado | mean_rh100 | m | 3 | 15 | ALTA |
| Cobertura do copado | mean_L2B_cover | Fraccao (0-1) | 0,30 | 0,70 | BAIXA |
| Densidade de biomassa acima do solo | mean_L4A_agbd | Mg/ha | 5 | 100 | MEDIA |
| Indice de Area Foliar | mean_L2B_pai | Adimensional (m2/m2) | 0,05 | 2,0 | BAIXA |
| Stock de carbono | mean_L4A_carbono_mgha | Mg C/ha | -- | -- | -- (nao normalizado) |

---

## Classificacoes de Confianca GEDI

| Pegadas GEDI (Point_Count) | Confianca | Utilizacao |
|----------------------------|-----------|-----------|
| >= 20 | ALTA | Fiavel para linha de base e analise de tendencias |
| 6-19 | MODERADA | Aceitavel para linha de base; sinalizar nos resultados |
| <= 5 | BAIXA | Apenas descritiva; excluir da analise de tendencias |

---

## Exercicio 1: Conta de Condicao a partir de Dados Brutos do GEDI (30 minutos)

**Tarefa:** Calcular o indice de condicao para um activo do Save e um de Morrumbene.

**Activo do Save escolhido:** _________________________ (Asset ID: _____)

| Indicador | Observado | Degradado | Pristino | IC = (obs - degr)/(prist - degr) | IC limitado |
|-----------|-----------|-----------|----------|----------------------------------|------------|
| Altura do copado (m) | | 3 | 15 | | |
| Cobertura do copado (fraccao) | | 0,30 | 0,70 | | |
| AGBD (Mg/ha) | | 5 | 100 | | |
| IAF | | 0,05 | 2,0 | | |
| **ICC composto** | | | | | |

Point_Count: _________ Classificacao de confianca: _________

**Activo de Morrumbene escolhido:** _________________________ (Asset ID: _____)

| Indicador | Observado | Degradado | Pristino | IC = (obs - degr)/(prist - degr) | IC limitado |
|-----------|-----------|-----------|----------|----------------------------------|------------|
| Altura do copado (m) | | 3 | 15 | | |
| Cobertura do copado (fraccao) | | 0,30 | 0,70 | | |
| AGBD (Mg/ha) | | 5 | 100 | | |
| IAF | | 0,05 | 2,0 | | |
| **ICC composto** | | | | | |

Point_Count: _________ Classificacao de confianca: _________

**Stock de carbono para cada activo:**

| Activo | Densidade de carbono (Mg C/ha) | Area (ha) | Carbono total (Mg C) | Equivalente CO2 (Mg CO2) |
|--------|-------------------------------|-----------|---------------------|--------------------------|
| Activo do Save | | | | |
| Activo de Morrumbene | | | | |

**Questoes de interpretacao:**

a. Qual o activo com o ICC composto mais elevado? A comparacao e justa, considerando as classificacoes de confianca?

b. Algum indicador produziu um valor negativo antes da limitacao? O que isso significa ecologicamente?

c. Qual o indicador individual que mais contribui para o ICC composto em cada activo?

---

## Exercicio 2: Agregacao Ponderada pela Area (20 minutos)

**Tarefa:** Calcular o ICC ao nivel do local para um dos locais (Save ou Morrumbene).

**Local escolhido:** _________________________

| Activo | Area (ha) | ICC | ICC x Area |
|--------|-----------|-----|------------|
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| **Total** | | | |

**ICC_local = Total (ICC x Area) / Total Area = _________ / _________ = _________**

**Carbono total do local:**

| Activo | Carbono total (Mg C) |
|--------|---------------------|
| | |
| | |
| | |
| **Total do local** | |
| **Equivalente CO2** | |

**Questoes de interpretacao:**

a. Quanto difere o ICC ponderado pela area de uma media simples (nao ponderada) dos ICC dos activos?

b. Qual o activo com maior influencia no ICC ao nivel do local? Porque?

---

## Exercicio 3: Comparacao entre Locais e entre Paises (20 minutos)

**Parte A: Save vs. Morrumbene**

| Metrica | Save | Morrumbene |
|---------|------|-----------|
| ICC composto (ponderado pela area) | | |
| Carbono total (Mg C) | | |
| Confianca media GEDI | | |
| Numero de activos | | |

Qual o local em melhor condicao? _________________________

Qual o local com dados mais fiaveis? _________________________

**Parte B: Mocambique vs. Quenia**

IC composto de mangal do Quenia = 0,397 (baseado em campo: 5 indicadores)
ICC composto de Mocambique = _________ (baseado em GEDI: 4 indicadores)

Podem ser directamente comparados? (Assinale uma opcao): SIM / NAO / PARCIALMENTE

Explique a sua resposta:

_______________________________________________________________

_______________________________________________________________

O que seria necessario para tornar a comparacao justa?

_______________________________________________________________

---

## Modelo de Tabela de Contas de Condicao SCEE CE

Preencha para o local que lhe foi atribuido:

| Ecossistema | Local | Activo | Area (ha) | IC Altura | IC Cobertura | IC AGBD | IC IAF | ICC | Confianca | Ano |
|-------------|-------|--------|-----------|-----------|-------------|---------|--------|-----|-----------|-----|
| MFT1.2 | | | | | | | | | | 2025 |
| MFT1.2 | | | | | | | | | | 2025 |
| MFT1.2 | | | | | | | | | | 2025 |

---

## Lembretes sobre Qualidade dos Dados

1. Todos os valores de condicao e carbono sao **PROVISORIOS** ate validacao de campo
2. IC de cobertura do copado = 0 em ambos os locais; pode ser artefacto de medicao do GEDI
3. Erros padrao do AGBD sao ~126-129% da media; reportar o carbono com limites de incerteza
4. Activos 2 e 4 do Save tem apenas 1-2 pegadas GEDI; nao utilizar para analise de tendencias
5. As estimativas de carbono utilizam areas dos poligonos de activos, nao as extensoes completas do GMW 2020

---

*Materiais da oficina: Elaboracao de Contas de Ecossistemas de Mangal a partir de Deteccao Remota*
*Data: _______________ | Nome do participante: _______________*
