# Mocambique -- Contabilidade Ecossistematica SCEE CE: Metodologia Completa

**Projecto:** AFRICA -- accounts / Mocambique
**Quadro:** Sistema de Contabilidade Economica e Ambiental -- Contabilidade dos Ecossistemas (SCEE CE)
**Tipo de ecossistema:** Florestas de Mangal (MFT1.2)
**Ambito geografico:** Estuario do Save (Provincia de Gaza) + Estuario de Morrumbene (Provincia de Inhambane)
**Periodo contabilistico:** 2025-2026
**Fonte de dados primaria:** NASA GEDI LiDAR (L2A, L2B, L4A v2); observacoes 2024-2025
**Linha de base de extensao:** Global Mangrove Watch v4 (GMW 2020)

---

## 1. Introducao e Quadro Conceptual

### 1.1 Ambito do Piloto de Mocambique

O piloto de Mocambique produz contas de condicao, extensao e carbono segundo o quadro SCEE CE para florestas de mangal em dois locais estuarinos ao longo da costa sul de Mocambique. Ao contrario do piloto do Quenia (que utiliza dados de levantamentos de campo), o piloto de Mocambique demonstra uma abordagem de deteccao remota utilizando o LiDAR espacial NASA GEDI como fonte de dados primaria.

Esta abordagem e relevante para paises e locais onde:
- O acesso para levantamentos de campo e limitado ou logisticamente desafiante
- E necessaria uma grande cobertura espacial em multiplos locais
- As metricas de condicao estrutural (altura, biomassa, cobertura) sao prioritarias
- E necessario estabelecer uma linha de base antes dos levantamentos de validacao de campo

### 1.2 Tipos de Contas

| Conta | Estado | Fonte de Dados |
|-------|--------|----------------|
| Condicao (estrutural) | CONCLUIDA (PROVISORIA) | NASA GEDI LiDAR |
| Stock de carbono (fisico) | CONCLUIDO (PROVISORIO) | GEDI AGBD x area do activo |
| Extensao (por unidade administrativa) | CONCLUIDA | GMW 2020 + ArcGIS |

Todos os valores de condicao e carbono sao PROVISORIOS, aguardando levantamentos de validacao de campo previstos para Marco-Maio de 2026.

---

## 2. Locais de Estudo

### 2.1 Estuario do Save (Provincia de Gaza)

**Localizacao:** Distritos de Nova Mambone e Bazaruto, Provincia de Gaza
**Extensao GMW 2020:** ~12 085 ha (estuario completo)
**Area dos poligonos de activos:** 1 877,54 ha (8 activos delimitados com cobertura GEDI)
**Pegadas GEDI:** 84

### 2.2 Estuario de Morrumbene (Provincia de Inhambane)

**Localizacao:** Distrito de Inhambane, Provincia de Inhambane
**Extensao GMW 2020:** ~1 677 ha (estuario completo)
**Area dos poligonos de activos:** 1 068,76 ha (3 activos delimitados com cobertura GEDI)
**Pegadas GEDI:** 195

### 2.3 Conceito de Activo

Cada estuario e subdividido em **activos de mangal** discretos -- unidades poligonais contiguas delimitadas a partir das fronteiras do GMW. Cada activo e caracterizado independentemente pelo GEDI, permitindo a analise da heterogeneidade intra-local.

---

## 3. Fontes de Dados e Variaveis GEDI

### 3.1 Esquema de Colunas

| Coluna | Unidade | Descricao |
|--------|---------|-----------|
| Asset_ID | -- | Identificador unico por unidade de mangal |
| mean_rh100 | m | Altura media do copado (percentil RH100) |
| mean_L4A_agbd | Mg/ha | Densidade media de biomassa acima do solo |
| mean_L4A_agbd_se | Mg/ha | Erro padrao da estimativa de AGBD |
| mean_L2B_cover | Fraccao (0-1) | Cobertura media do copado |
| mean_L2B_pai | Adimensional (m2/m2) | Indice de Area Foliar medio |
| mean_L4A_carbono_mgha | Mg C/ha | Stock medio de carbono por unidade de area |
| Point_Count | Contagem | Numero de pegadas GEDI que contribuem para a media do activo |

---

## 4. Conta de Extensao

### 4.1 Metodo

A extensao dos mangais e derivada do Global Mangrove Watch v4 (GMW 2020, resolucao 25 m), intersectada com limites administrativos em ArcGIS/QGIS.

**Fluxo de trabalho SIG em tres etapas:**

1. **Intersectar** poligonos de mangal GMW 2020 com limites administrativos nivel 3
2. **Calcular area** (hectares) para cada poligono recortado
3. **Resumir** area de mangal por unidade administrativa (provincia/distrito)

### 4.2 Resultados de Extensao

| Local | Extensao GMW 2020 (ha) | Area dos Poligonos de Activos (ha) | Activos |
|-------|------------------------|------------------------------------|---------|
| Estuario do Save | 12 085 | 1 877,54 | 8 |
| Estuario de Morrumbene | 1 677 | 1 068,76 | 3 |

---

## 5. Conta de Condicao -- Abordagem por Deteccao Remota

### 5.1 Quatro Indicadores Estruturais

| Indicador | Variavel GEDI | Unidade | O que mede |
|-----------|--------------|---------|------------|
| Altura do copado | mean_rh100 | m | Estrutura maxima da vegetacao; indicador de maturidade florestal |
| Cobertura do copado | mean_L2B_cover | Fraccao (0-1) | Densidade da camada superior da vegetacao; fecho do copado |
| Densidade de biomassa acima do solo | mean_L4A_agbd | Mg/ha | Biomassa seca total acima do solo por hectare |
| Indice de Area Foliar | mean_L2B_pai | Adimensional (m2/m2) | Area total unilateral de folhas e caules por area de solo |

### 5.2 Niveis de Referencia

| Indicador | Degradado (IC=0) | Pristino (IC=1) | Confianca | Fonte |
|-----------|------------------|-----------------|-----------|-------|
| Altura do copado | 3 m | 15 m | ALTA | Fatoyinbo 2008; Lagomasino 2015; Sitoe 2016 (OIO/Mocambique) |
| Cobertura do copado | 0,30 | 0,70 | BAIXA | Provisorio; sem referencia publicada especifica para o OIO |
| AGBD | 5 Mg/ha | 100 Mg/ha | MEDIA | Godoy e De Lacerda 2015 (degradado: 6-9 Mg/ha); intacto >100 Mg/ha |
| IAF | 0,05 | 2,0 | BAIXA | Provisorio; sem referencia publicada especifica para o OIO |

### 5.3 Formula de Normalizacao

Reescalonamento linear:

```
IC = limitar((observado - degradado) / (pristino - degradado), 0, 1)
```

### 5.4 Indice de Condicao Composto

Media com pesos iguais dos quatro indicadores normalizados por activo:

```
ICC = media(IC_rh100, IC_cobertura, IC_agbd, IC_iaf)
```

### 5.5 Agregacao Ponderada pela Area ao Nivel do Local

```
ICC_local = soma(ICC_activo_i x area_ha_i) / soma(area_ha_i)
```

---

## 6. Conta de Carbono

### 6.1 Metodo

```
Carbono total (Mg C) = densidade de carbono (Mg C/ha) x area (ha)
Equivalente CO2 (Mg CO2) = carbono total x 3,664 (razao de peso molecular 44/12)
Incerteza (Mg C) = erro padrao AGBD x 0,47 x area
```

### 6.2 Resultados

| Local | Densidade de carbono (Mg C/ha) | Area do activo (ha) | Carbono total (Mg C) | Equivalente CO2 (Mg CO2) |
|-------|-------------------------------|---------------------|---------------------|--------------------------|
| Estuario do Save | 5,94 | 1 877,54 | ~11 150 | ~40 850 |
| Estuario de Morrumbene | 5,15 | 1 068,76 | ~5 500 | ~20 150 |
| **Combinado** | **5,64** | **2 946,30** | **~16 650** | **~61 000** |

---

## 7. Quadro de Controlo de Qualidade e Confianca

### 7.1 Confianca GEDI por Activo

| Limiar | Classificacao | Utilizacao na contabilidade |
|--------|--------------|----------------------------|
| >= 20 pegadas | ALTA | Fiavel para linha de base e analise de tendencias |
| 6-19 pegadas | MODERADA | Aceitavel para linha de base; sinalizar nos resultados |
| <= 5 pegadas | BAIXA | Apenas descritiva; excluir da analise de tendencias |

### 7.2 Problemas Conhecidos de Qualidade de Dados

| Problema | Impacto | Mitigacao |
|----------|---------|-----------|
| Cobertura do copado muito baixa (4-9%) | Pode ser artefacto do GEDI | Validacao cruzada com imagens opticas Sentinel-2 |
| Erro padrao do AGBD ~126-129% da media | Incerteza relativa muito elevada | Reportar todos os valores de biomassa/carbono com limites de incerteza |
| Activos 2 e 4 do Save (1-2 pegadas) | Estimativas nao fiaveis | Sinalizar como BAIXA; excluir da analise de tendencias |
| Sem dados de composicao de especies | Impossivel avaliar condicao biotica | Requer levantamentos de campo ou mapeamento optico de especies |
| Ponto temporal unico (2024-2025) | Sem deteccao de alteracoes temporais | Apenas linha de base; necessaria nova amostragem para tendencias |

---

## 8. Resultados

### 8.1 Conta de Condicao -- Nivel do Local (Ponderada pela Area)

| Local | IC Altura | IC Cobertura | IC AGBD | IC IAF | ICC Composto |
|-------|-----------|-------------|---------|--------|-------------|
| Estuario do Save | 0,187 | 0,018 | 0,095 | 0,171 | 0,118 |
| Estuario de Morrumbene | 0,190 | 0,000 | 0,063 | 0,036 | 0,072 |

### 8.2 Comparacao entre Locais

| Dimensao | Estuario do Save | Morrumbene | Diferenca |
|----------|-----------------|-----------|-----------|
| Pegadas GEDI | 84 | 195 | Morrumbene: 2,3x mais cobertura |
| Altura media do copado | 5,07 m | 5,27 m | Semelhante |
| AGBD medio | 12,63 Mg/ha | 10,95 Mg/ha | Save: 15% mais denso |
| Cobertura media do copado | 8,8% | 4,9% | Save: 1,8x mais fecho |
| IAF medio | 0,29 | 0,12 | Save: 2,4x mais area foliar |
| ICC composto | 0,118 | 0,072 | Save: 64% melhor condicao |
| Carbono total | ~11 150 Mg C | ~5 500 Mg C | Save: 2,0x mais carbono |

---

## 9. Cadeia de Analise

```
Etapa 1: INGESTAO -- Leitura de CSV da pasta archive (readr::read_csv)
Etapa 2: CONTROLO DE QUALIDADE -- Validar Point_Count; sinalizar activos de confianca BAIXA
Etapa 3: CONVERSAO DE AREA -- Save: area_ha do ArcGIS; Morrumbene: conversao de graus quadrados
Etapa 4: NORMALIZACAO (0-1) -- IC = limitar((obs - degradado)/(pristino - degradado), 0, 1)
Etapa 5: ICC POR ACTIVO -- Media com pesos iguais dos 4 IC
Etapa 6: AGREGACAO PONDERADA PELA AREA -- ICC_local = soma ponderada pela area
Etapa 7: CONTA DE CARBONO -- carbono total = densidade x area
Etapa 8: EXPORTACAO SCEE CE -- Tabela de condicao + tabela de carbono
```

---

## 10. Ficheiros de Saida

Todos em `Mozambique/03_outputs/` com prefixo MOZ_:

| Ficheiro | Conteudo |
|----------|----------|
| MOZ_mangrove_condition_by_asset.csv | IC por activo + composto + area + confianca (11 linhas) |
| MOZ_mangrove_condition_by_site.csv | Resumo de condicao ponderado por area ao nivel do local (2 linhas) |
| MOZ_mangrove_seea_condition_account.csv | Formato SCEE CE (11 linhas) |
| MOZ_mangrove_carbon_account.csv | Stock de carbono por activo + totais (11 linhas) |
| MOZ_FINDINGS_OVERVIEW.md | Analise narrativa completa com interpretacoes |

---

## 11. Pontos em Aberto e Limitacoes

### 11.1 Prioridade Alta

| Ponto | Estado | Impacto |
|-------|--------|---------|
| Validacao de campo (Mar-Mai 2026) | BLOQUEADO | Todos os valores permanecem PROVISORIOS |
| Validacao cruzada de cobertura (Sentinel-2) | PENDENTE | IC de cobertura = 0 em ambos os locais |
| Nivel de referencia para AGBD (100 Mg/ha) | PROVISORIO | Sem valor confirmado especifico de Mocambique |

### 11.2 Trabalho Futuro

1. **Validacao de campo:** Minimo de 3 parcelas por activo; recolher altura, DAP, densidade de caules, especies, regeneracao
2. **Verificacao Sentinel-2:** Derivar estimativa independente de cobertura a partir de NDVI
3. **Analise multi-periodo:** Futuras aquisicoes GEDI (2026-2027) para deteccao de alteracoes
4. **Mapeamento de especies:** Imagens opticas de alta resolucao ou identificacao de campo
5. **Servicos ecossistemicos:** Valorizacao no mercado de carbono, funcao de viveiro para a pesca, proteccao costeira

---

## 12. Referencias

Fatoyinbo, T.E., et al. (2008). Extensao, altura, biomassa e estimativa de carbono das florestas de mangal de Mocambique. *Global Change Biology*.

Godoy, M.D.P. e De Lacerda, L.D. (2015). Resposta dos mangais as alteracoes climaticas. *Wetlands*, 35, 1-13.

Lagomasino, D., et al. (2015). Medicao de perda e ganho de carbono de mangal em deltas. *Remote Sensing of Environment*.

Sitoe, A.A., et al. (2016). Biomassa e stocks de carbono das florestas de mangal da Baia de Sofala. *Forests*, 5(7), 1967-1981.

Bunting, P., et al. (2022). Global Mangrove Watch v4.019. GMW / JAXA.

NASA GEDI. Global Ecosystem Dynamics Investigation. Produtos L2A, L2B, L4A (v2).

SCEE CE (2021). Sistema de Contabilidade Economica e Ambiental -- Contabilidade dos Ecossistemas. Nacoes Unidas.

---

*Versao: 1.0*
*Data: 2026-03-29*
*Estado: PROVISORIO -- todos os valores de condicao e carbono aguardam validacao de campo*
*Documentos complementares: MOZ_GUIA_FACILITADOR.md, MOZ_FICHA_PARTICIPANTE.md*
