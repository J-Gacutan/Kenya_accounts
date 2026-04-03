# Elaboracao de Contas de Ecossistemas de Mangal a partir de Deteccao Remota: Guia do Facilitador

## SCEE CE Mocambique -- Contas de Condicao e Carbono de Mangais com NASA GEDI LiDAR

---

## Diapositivo 1: Titulo

Elaboracao de Contas de Condicao e Carbono de Ecossistemas de Mangal para Mocambique

Oficina pratica para transformar dados de LiDAR espacial NASA GEDI em tabelas de contas de condicao e carbono segundo o quadro SCEE CE -- abrangendo o Estuario do Save e o Estuario de Morrumbene.

Notas do facilitador: Bem-vindos. Esta sessao demonstra como construir contas de condicao ecossistematica e contas de carbono a partir de dados de deteccao remota por satelite, sem necessidade de levantamentos de campo. O piloto de Mocambique utiliza o LiDAR espacial NASA GEDI como fonte de dados primaria para quatro indicadores estruturais. No final da oficina, os participantes serao capazes de normalizar os resultados do GEDI em indices de condicao, agregar por activos, calcular stocks de carbono e montar tabelas SCEE CE. Esta abordagem e aplicavel em qualquer local com cobertura GEDI -- os participantes podem replica-la para outros mangais na regiao do Oceano Indico Ocidental (OIO).

---

## Diapositivo 2: O que ha de diferente nas contas por deteccao remota?

| Dimensao | Baseada em campo (ex.: Quenia) | Deteccao remota (Mocambique) |
|----------|--------------------------------|------------------------------|
| O que se mede | Especies, saude, DAP, qualidade | Altura, cobertura, biomassa, area foliar |
| Cobertura espacial | 10-30 locais com parcelas | Sistema estuarino completo |
| Custo | Elevado (equipa de campo) | Baixo (dados satelitais de acesso livre) |
| Dados de especies | Sim | Nao |
| Resolucao temporal | Datas fixas de levantamento | Janelas de passagem do satelite |
| Validacao | Medicao directa | Requer verificacao de campo |

Ambas as abordagens produzem contas de condicao SCEE CE na mesma escala 0-1. Sao complementares, nao concorrentes.

Notas do facilitador: A mensagem principal e que as contas por deteccao remota nao sao inferiores as contas baseadas em campo -- respondem a questoes diferentes em escalas diferentes. O GEDI fornece a condicao estrutural em todo o estuario. Os levantamentos de campo fornecem detalhe biotico em locais especificos. A abordagem ideal combina ambos: GEDI para mapeamento completo, levantamentos de campo para calibracao e dados de especies. Mocambique comeca com GEDI e acrescenta dados de campo posteriormente (previsto para Marco-Maio de 2026).

---

## Diapositivo 3: Os quatro indicadores GEDI

| Indicador | Variavel GEDI | Unidade | O que nos diz |
|-----------|--------------|---------|---------------|
| Altura do copado | mean_rh100 | m | Qual a altura das arvores? (maturidade florestal) |
| Cobertura do copado | mean_L2B_cover | Fraccao (0-1) | Qual o grau de fecho do copado? (densidade florestal) |
| Densidade de biomassa | mean_L4A_agbd | Mg/ha | Quanta madeira existe? (stock em pe) |
| Indice de Area Foliar | mean_L2B_pai | Adimensional (m2/m2) | Quanta superficie foliar? (capacidade fotossintetica) |

Acresce uma quinta metrica -- densidade de carbono (mean_L4A_carbono_mgha) -- que NAO e normalizada, sendo utilizada apenas na conta de carbono.

Notas do facilitador: GEDI significa Global Ecosystem Dynamics Investigation (Investigacao Global sobre Dinamicas dos Ecossistemas) -- um instrumento LiDAR instalado na Estacao Espacial Internacional. Cada "pegada" GEDI tem aproximadamente 25 m de diametro. O instrumento emite impulsos laser em direccao a superficie terrestre e mede o sinal de retorno. Florestas altas e densas produzem retornos fortes do topo do copado (dando a altura) e retornos multiplos atraves do copado (dando a cobertura e o IAF). O produto L4A combina a altura com modelos alometricos para estimar a biomassa.

---

## Diapositivo 4: O quadro de activos

```
Estuario (ex.: Save)
    |
    +-- Activo 1 (841 ha, 17 pegadas GEDI)
    +-- Activo 2 (27 ha, 2 pegadas) <-- confianca BAIXA
    +-- Activo 3 (104 ha, 3 pegadas) <-- destaque: mais alto e mais denso
    +-- Activo 4 (6 ha, 1 pegada) <-- confianca BAIXA
    +-- Activo 5 (117 ha, 17 pegadas)
    +-- Activo 6 (248 ha, 31 pegadas) <-- confianca ALTA
    +-- Activo 7 (236 ha, 7 pegadas)
    +-- Activo 8 (299 ha, 6 pegadas) <-- segunda maior produtividade
```

Cada activo de mangal e um poligono contiguo delimitado a partir das fronteiras do GMW, com as suas proprias medicoes GEDI.

Notas do facilitador: O conceito de activo e central nesta metodologia. Em vez de tratar o estuario como um bloco uniforme, subdividimo-lo em unidades florestais discretas. Isto revela a heterogeneidade: o Activo 3 do Save tem 7,8 m de altura de copado e 27 Mg/ha de biomassa, enquanto o Activo 6 tem apenas 4,6 m de altura e 9 Mg/ha de biomassa. Esta heterogeneidade e invisivel numa media ao nivel do local. Perguntem aos participantes: "Porque e que a heterogeneidade importa para a politica de conservacao?" Resposta: identifica quais os talhoes de alto valor (prioritarios para proteccao) e quais os degradados (prioritarios para restauracao).

---

## Diapositivo 5: Niveis de confianca GEDI

| Classificacao | Pegadas GEDI | Utilizacao na contabilidade |
|---------------|--------------|----------------------------|
| ALTA | >= 20 | Fiavel para linha de base E analise de tendencias |
| MODERADA | 6-19 | Aceitavel para linha de base; sinalizar nos resultados |
| BAIXA | <= 5 | Apenas descritiva; excluir da analise de tendencias |

Notas do facilitador: O GEDI amostra de forma discreta -- nem todos os pixeis tem uma medicao. Alguns activos tem muitas pegadas (Activo 2 de Morrumbene: 95 pegadas = confianca ALTA), enquanto outros tem muito poucas (Activo 4 do Save: 1 pegada = confianca BAIXA). Com 1 pegada, a "media" e apenas uma medicao unica -- pode ser da arvore mais alta ou da mais baixa. Verifiquem sempre o Point_Count antes de interpretar a condicao de um activo. Perguntem: "Se tivessem de aconselhar um governo sobre creditos de carbono, usariam uma estimativa de 1 pegada ou de 95 pegadas?"

---

## Diapositivo 6: Formula de normalizacao

Mesma formula da conta de mangal do Quenia -- reescalonamento linear:

```
IC = limitar((observado - degradado) / (pristino - degradado), 0, 1)
```

Se observado < degradado: IC = 0 (abaixo da condicao minima)
Se observado > pristino: IC = 1 (em condicao de referencia ou acima)

Notas do facilitador: Escrevam a formula no quadro. Lembrem que esta e a mesma formula de Tipo 3 utilizada para os mangais do Quenia (densidade de caules, DAP, altura, cobertura). A unica diferenca e que o Quenia utiliza medicoes de campo e Mocambique utiliza medicoes GEDI. O quadro de normalizacao e universal -- funciona com qualquer fonte de dados, desde que se disponha de niveis de referencia adequados.

---

## Diapositivo 7: Niveis de referencia

| Indicador | Degradado (IC=0) | Pristino (IC=1) | Confianca |
|-----------|------------------|-----------------|-----------|
| Altura do copado | 3 m | 15 m | ALTA |
| Cobertura do copado | 0,30 | 0,70 | BAIXA |
| AGBD | 5 Mg/ha | 100 Mg/ha | MEDIA |
| IAF | 0,05 | 2,0 | BAIXA |

Notas do facilitador: Dois dos quatro niveis de referencia tem confianca BAIXA (cobertura do copado e IAF). Trata-se de uma limitacao significativa. A referencia para a altura do copado e de confianca ALTA porque estudos publicados sobre o OIO e Mocambique sustentam o intervalo 3-15 m (Fatoyinbo 2008, Lagomasino 2015, Sitoe 2016). A referencia para AGBD e de confianca MEDIA porque o limite inferior para areas degradadas e sustentado por Godoy e De Lacerda (2015), mas o limite superior de pristino (100 Mg/ha) provem de literatura tropical geral, nao especifica de Mocambique.

Perguntem: "Ambos os locais tem cobertura do copado abaixo do limiar de degradacao (0,30). O IC e 0 para cobertura. Isto significa que os mangais nao tem copado?" Nao -- significa que a cobertura medida pelo GEDI (4-9%) esta abaixo do limiar. No entanto, as pegadas GEDI de 25 m podem subestimar sistematicamente a cobertura em mangais com estrutura esparsa. E por isto que a validacao cruzada com Sentinel-2 e necessaria antes de publicar IC baseados na cobertura.

---

## Diapositivo 8: Exemplo guiado -- altura do copado, Estuario do Save, Activo 3

Activo 3 do Save, o talhao de destaque.

Altura media do copado (rh100) = 7,80 m. Referencia: Degradado = 3 m, Pristino = 15 m.

```
IC = (7,80 - 3) / (15 - 3) = 4,80 / 12 = 0,40
```

Isto significa que o activo esta a 40% do intervalo entre o estado degradado e o estado pristino para a altura do copado.

Notas do facilitador: Pecam aos participantes que calculem no papel. Depois comparem com o Activo 6 do Save (altura = 4,64 m): IC = (4,64 - 3) / (15 - 3) = 1,64 / 12 = 0,14. O Activo 3 tem quase 3 vezes o IC de altura do Activo 6. Perguntem: "Qual o activo que priorizariam para proteccao?" (Activo 3 -- e o talhao mais maduro e produtivo.) "E qual para restauracao?" (Activo 6 -- tem dados de confianca ALTA (31 pegadas) e condicao baixa, o que significa que o potencial de restauracao e claro.)

---

## Diapositivo 9: Exemplo guiado -- densidade de biomassa, Morrumbene, Activo 2

Activo 2 de Morrumbene, o activo com melhor amostragem (95 pegadas).

AGBD media = 10,79 Mg/ha. Referencia: Degradado = 5 Mg/ha, Pristino = 100 Mg/ha.

```
IC = (10,79 - 5) / (100 - 5) = 5,79 / 95 = 0,061
```

Isto significa que o activo esta a 6% do intervalo de referencia para a biomassa pristina.

Notas do facilitador: Este e um IC muito baixo. Perguntem: "Isto significa que o mangal esta morto?" Nao -- significa que a biomassa e muito baixa em comparacao com o que um mangal tropical intacto poderia conter. Ha duas explicacoes: (a) a floresta esta genuinamente degradada/esparsa, ou (b) o AGBD derivado do GEDI subestima a biomassa real (notem que o erro padrao e de 14 Mg/ha -- superior a estimativa media de 10,8 Mg/ha). E por isto que a conta e PROVISORIA. A validacao de campo dira qual a explicacao correcta.

---

## Diapositivo 10: Indice de condicao composto

Quatro IC combinados num composto por activo:

```
ICC = media(IC_altura, IC_cobertura, IC_agbd, IC_iaf)
```

**Exemplo do Activo 3 do Save:**

| Indicador | Observado | IC |
|-----------|-----------|-----|
| Altura | 7,80 m | 0,400 |
| Cobertura | 0,434 | 0,336 |
| AGBD | 27,33 Mg/ha | 0,235 |
| IAF | 1,742 | 0,868 |
| **Composto** | | **0,460** |

Comparacao: a maioria dos outros activos do Save tem ICC entre 0,04 e 0,07.

Notas do facilitador: O Activo 3 e um valor atipico -- pontua 6-10 vezes mais do que os vizinhos. Isto demonstra porque e que o quadro de activos e importante: uma media ao nivel do local ocultaria este talhao produtivo. Em termos de conservacao, o Activo 3 e um ponto de destaque que pode estar a manter-se devido a sua densa estrutura de copado. Mas atentem: tem apenas 3 pegadas GEDI (confianca BAIXA). Os valores elevados podem ser reais ou podem reflectir um enviesamento de amostragem. A validacao de campo no Activo 3 e uma prioridade.

---

## Diapositivo 11: Agregacao ponderada pela area ao nivel do local

Os activos sao ponderados pela area ao calcular o ICC ao nivel do local:

```
ICC_local = soma(ICC_i x area_ha_i) / soma(area_ha_i)
```

**Estuario do Save:**

| Activo | Area (ha) | ICC | ICC x Area |
|--------|-----------|-----|------------|
| 1 | 841 | 0,059 | 49,6 |
| 2 | 27 | 0,061 | 1,6 |
| 3 | 104 | 0,427 | 44,4 |
| 4 | 6 | 0,066 | 0,4 |
| 5 | 117 | 0,126 | 14,7 |
| 6 | 248 | 0,045 | 11,2 |
| 7 | 236 | 0,066 | 15,6 |
| 8 | 299 | 0,279 | 83,4 |
| **Total** | **1 878** | | **220,9** |

ICC_local = 220,9 / 1 878 = **0,118**

Notas do facilitador: Percorram o calculo de ponderacao. O Activo 1 (841 ha, ICC baixo) domina a media ponderada devido a sua dimensao. O Activo 3 (104 ha, ICC alto) contribui menos, apesar de ser o melhor talhao. Perguntem: "Isto e justo?" Sim -- a ponderacao por area reflecte o estado real do activo ecossistemico. Um pequeno talhao excelente dentro de uma floresta grande e degradada nao torna a floresta saudavel no seu conjunto. Mas IDENTIFICA onde concentrar o investimento em restauracao.

---

## Diapositivo 12: Conta de carbono

Stock de carbono = densidade de carbono x area

**Exemplo do Estuario do Save (Activo 6, confianca ALTA):**

Densidade de carbono = 4,27 Mg C/ha. Area = 248 ha.

```
Carbono total = 4,27 x 248 = 1 059 Mg C
Equivalente em CO2 = 1 059 x 3,664 = 3 880 Mg CO2
```

Notas do facilitador: Percorram a multiplicacao. Depois perguntem: "Se um credito voluntario de carbono valer USD 10-30 por tonelada de CO2, quanto vale o Activo 6?" (3 880 x $10 = $38 800 a $116 400 no limite inferior -- apenas ilustrativo; a determinacao efectiva do preco dos creditos requer adicionalidade, permanencia e certificacao). Notem que este e o STOCK, nao a taxa anual de sequestro. Os creditos de carbono sao normalmente emitidos para sequestro (fluxo anual), nao para stock em pe. O stock em pe e relevante para REDD+ (desmatamento evitado) e nao para creditos de reflorestacao. Reportem sempre o carbono com limites de incerteza (media +/- 1 EP).

---

## Diapositivo 13: Tabela de contas de condicao SCEE CE

Estrutura final de saida:

| Ecossistema | Local | Activo | Area (ha) | IC Altura | IC Cobertura | IC AGBD | IC IAF | ICC | Confianca | Ano |
|-------------|-------|--------|-----------|-----------|-------------|---------|--------|-----|-----------|-----|
| MFT1.2 | Save | 3 | 104 | 0,400 | 0,207 | 0,235 | 0,868 | 0,427 | BAIXA | 2025 |
| MFT1.2 | Save | 6 | 248 | 0,137 | 0,000 | 0,043 | 0,000 | 0,045 | ALTA | 2025 |
| MFT1.2 | Morrumbene | 2 | 448 | 0,191 | 0,000 | 0,061 | 0,038 | 0,073 | ALTA | 2025 |

Notas do facilitador: Mostrem a tabela completa de 11 linhas a partir do ficheiro CSV. Sublinem o contraste entre o Activo 3 (ICC = 0,43, confianca BAIXA) e o Activo 6 (ICC = 0,05, confianca ALTA). Perguntem: "Para um relatorio de politica, em qual valor confiariam mais?" (Activo 6 -- os dados sao mais fiaveis, mesmo que a condicao seja inferior.) E depois: "O que recomendariam para a publicacao SCEE CE?" (Reportar ambos, com a classificacao de confianca bem visivel. Nao ocultar dados incertos -- reporta-los de forma transparente.)

---

## Diapositivo 14: Comparacao Save vs. Morrumbene

| Dimensao | Save | Morrumbene |
|----------|------|-----------|
| Area (activos) | 1 878 ha | 1 069 ha |
| ICC composto | 0,118 | 0,072 |
| Carbono total | ~11 150 Mg C | ~5 500 Mg C |
| Cobertura GEDI | Desigual (1-31 por activo) | Uniforme (15-95 por activo) |
| Heterogeneidade | Elevada (ICC 0,04-0,43) | Baixa (ICC 0,07-0,08) |

Notas do facilitador: O Save e maior, mais denso, mais rico em carbono e mais variavel. Morrumbene e menor, mais esparso, mas muito melhor amostrado pelo GEDI. Perguntem: "Se tivessem de escolher um local para um projecto de carbono, qual escolheriam?" O Save tem mais carbono total, mas Morrumbene tem dados mais fiaveis e estrutura uniforme (mais facil de monitorizar). Este e um verdadeiro compromisso no planeamento da conservacao. Perguntem: "Se tivessem de escolher um local para uma missao de validacao de campo, qual escolheriam?" O Save -- porque tem activos de confianca BAIXA (2 e 4) e heterogeneidade elevada que necessita de verificacao no terreno.

---

## Diapositivo 15: Exercicio -- conta de condicao a partir de dados brutos do GEDI

Vao agora construir uma conta de condicao a partir de valores brutos do GEDI.

Dispoem de:
1. Uma ficha impressa com a formula de normalizacao e a tabela de niveis de referencia.
2. Os dados ao nivel do activo de MOZ_mangrove_condition_by_asset.csv (pre-carregados no Excel).

**Tarefa:**

1. Escolham um activo do Save e um de Morrumbene.
2. Para cada um, calculem o IC dos 4 indicadores utilizando os niveis de referencia.
3. Calculem o ICC composto (media dos 4 IC).
4. Calculem o stock de carbono (densidade de carbono x area).
5. Atribuam uma classificacao de confianca com base no Point_Count.

Dispoem de 30 minutos.

Notas do facilitador: Circulem durante o exercicio. Erros comuns: (a) esquecer de limitar os IC negativos a 0 (especialmente a cobertura do copado, que esta abaixo do limiar de degradacao), (b) utilizar a normalizacao 0-1 em vez do intervalo degradado-pristino, (c) confundir densidade de carbono (Mg C/ha) com AGBD (Mg/ha) -- o carbono e aproximadamente 47% da biomassa, (d) nao verificar o Point_Count antes de atribuir a confianca.

---

## Diapositivo 16: Exercicio -- agregacao ponderada pela area

Utilizando o conjunto completo de dados ao nivel do activo para um local (Save ou Morrumbene):

1. Calculem o ICC ponderado pela area para todo o local.
2. Calculem o stock total de carbono do local (soma dos totais dos activos).
3. Expressem o stock de carbono em equivalentes de CO2.

Dispoem de 20 minutos.

Notas do facilitador: Este exercicio reforca o conceito de ponderacao por area. Se os participantes utilizarem o Save, devem constatar que o ICC ao nivel do local e puxado para baixo pelos activos grandes e de baixa condicao, apesar dos valores atipicos elevados (Activos 3 e 8). Se utilizarem Morrumbene, a estrutura uniforme significa que a ponderacao por area quase nao altera o resultado. Ambos os resultados sao instrutivos.

---

## Diapositivo 17: Exercicio -- comparacao entre locais e entre paises

Utilizando os resultados ao nivel do local:

1. Comparem o ICC do Save (0,118) com o ICC de Morrumbene (0,072). Qual o local em melhor condicao?
2. Agora comparem com o IC composto de mangal do Quenia (0,397). A conta do Quenia utiliza indicadores baseados em campo (densidade de caules, DAP, altura, cobertura, qualidade). Podem ser directamente comparados?
3. Discutam: o que seria necessario para tornar a comparacao justa?

Notas do facilitador: Este e o exercicio conceptualmente mais desafiante. O IC do Quenia de 0,40 utiliza indicadores e niveis de referencia diferentes dos do IC de Mocambique de 0,07-0,12. A escala 0-1 e comparavel em teoria (ambos medem "fraccao da condicao de referencia"), mas os niveis de referencia e os indicadores sao diferentes. Uma comparacao justa requereria: (a) medir os mesmos indicadores em ambos os locais, ou (b) utilizar o GEDI para os mangais do Quenia para criar uma conta estrutural paralela.

---

## Diapositivo 18: Validacao de campo -- o que se segue

**Previsto: Marco-Maio de 2026**

Dados de campo a recolher em cada activo (minimo 3 parcelas por activo):
- **Altura do copado:** Clinometro ou vara de medicao; comparar com GEDI rh100
- **DAP:** Todos os caules >= 2,5 cm num raio de 10 m
- **Densidade de caules:** Caules por m2
- **Composicao de especies:** Identificar proporcoes de Rhizophora, Ceriops, Avicennia, Bruguiera
- **Densidade de regeneracao:** Plantulas e juvenis < 1,3 m
- **Indicadores de perturbacao:** Cicatrizes de abate, erosao, senescencia

Notas do facilitador: A validacao de campo respondera a tres questoes criticas: (1) Os valores de cobertura do copado do GEDI sao reais ou artefactos? (2) O AGBD do GEDI corresponde a biomassa derivada de campo por equacoes alometricas? (3) Que especies estao presentes e a composicao de especies afecta os niveis de referencia? Uma vez recolhidos os dados de campo, a etiqueta PROVISORIO pode ser removida e as contas tornam-se CONFIRMADAS.

---

## Diapositivo 19: Perspectivas

Proximos passos para as contas SCEE CE de Mocambique:

1. **Validacao de campo (Mar-Mai 2026):** Verificacao do GEDI com parcelas in situ; actualizacao de PROVISORIO para CONFIRMADO.
2. **Verificacao cruzada de cobertura com Sentinel-2:** Validar estimativas baixas de cobertura; derivar mapa independente de cobertura.
3. **GEDI multi-periodo (2026-2027):** Futuras passagens do satelite para deteccao de alteracoes temporais.
4. **Mapeamento de especies:** Imagens opticas de alta resolucao ou identificacao de especies no campo.
5. **Servicos ecossistemicos:** Valorizacao no mercado de carbono, funcao de viveiro para a pesca, proteccao costeira.
6. **Tendencias de extensao:** Actualizacao do mapeamento de extensao baseado no GMW para 2025-2026.
7. **Replicacao:** Aplicar a mesma metodologia GEDI a outros mangais do OIO (Quenia, Tanzania, Madagascar).

Notas do facilitador: O piloto de Mocambique demonstra que uma linha de base credivel de condicao e uma conta de carbono podem ser produzidas a partir de dados satelitais de acesso gratuito. A metodologia e transferivel para qualquer mangal com cobertura GEDI. Os participantes de outros paises do OIO podem adaptar estes scripts e niveis de referencia para os seus proprios locais. O investimento fundamental e a validacao de campo -- sem ela, a conta permanece provisoria. Mas mesmo uma conta provisoria e util para priorizar areas de conservacao e estimar magnitudes de stock de carbono.

---

## Anexo A: Lista de verificacao do facilitador

### Cronograma indicativo

| Diapositivos | Conteudo | Duracao |
|--------------|----------|---------|
| 1-3 | Introducao, deteccao remota vs. campo, indicadores GEDI | 25 min |
| 4-5 | Quadro de activos e classificacoes de confianca | 15 min |
| 6-7 | Formula de normalizacao e niveis de referencia | 20 min |
| 8-10 | Exemplos guiados (altura, AGBD, composto) | 30 min |
| 11-12 | Agregacao e conta de carbono | 20 min |
| -- | Intervalo | 15 min |
| 13-14 | Tabela SCEE CE e comparacao entre locais | 15 min |
| 15 | Exercicio: conta de condicao a partir de dados GEDI | 30 min |
| 16 | Exercicio: agregacao ponderada pela area | 20 min |
| 17 | Exercicio: comparacao entre locais e paises | 20 min |
| 18 | Revisao e discussao | 25 min |
| 19 | Validacao de campo e perspectivas | 15 min |
| -- | **Total** | **~4,5 horas (meia jornada com intervalos)** |

---

## Anexo B: Resolucoes dos exercicios

### Exercicio 1: Conta de condicao

Exemplo: Activo 6 do Save (confianca ALTA, 31 pegadas)

| Indicador | Observado | Degradado | Pristino | IC |
|-----------|-----------|-----------|----------|-----|
| Altura | 4,64 m | 3 | 15 | (4,64-3)/(15-3) = 0,137 |
| Cobertura | 0,015 | 0,30 | 0,70 | (0,015-0,30)/(0,70-0,30) = negativo, limitar a 0,000 |
| AGBD | 9,08 Mg/ha | 5 | 100 | (9,08-5)/(100-5) = 0,043 |
| IAF | 0,032 | 0,05 | 2,0 | (0,032-0,05)/(2,0-0,05) = negativo, limitar a 0,000 |
| **Composto** | | | | **(0,137+0+0,043+0)/4 = 0,045** |

Carbono: 4,27 Mg C/ha x 248 ha = 1 059 Mg C. Equivalente CO2 = 3 880 Mg CO2.

---

## Anexo C: Perguntas frequentes dos participantes

**P: Posso utilizar o GEDI para qualquer floresta, nao apenas mangais?**
R: Sim. O GEDI cobre florestas a nivel global entre 51,6 graus N e 51,6 graus S (a orbita da Estacao Espacial Internacional). A mesma abordagem de normalizacao funciona para florestas terrestres com niveis de referencia adequados.

**P: Porque sao os IC tao baixos (0,04-0,12)?**
R: Os niveis de referencia assumem mangais tropicais intactos e maduros. Ambos os locais em estudo podem ser naturalmente esparsos ou degradados. Alem disso, o GEDI pode subestimar a cobertura e o IAF em copado fragmentado. A validacao de campo esclarecera qual o factor dominante.

**P: Um IC de 0,07 e "mau"?**
R: Significa que o ecossistema esta a 7% do intervalo entre o estado degradado e o estado pristino, considerando as quatro dimensoes estruturais. Se o contexto e "mau" depende: se a floresta sempre foi uma mata aberta e esparsa, um IC baixo pode ser natural. Se foi recentemente desmatada e esta em regeneracao, o IC melhorara com o tempo. Interpretem sempre a condicao no contexto ecologico.

**P: Porque e que o carbono nao e normalizado para 0-1?**
R: O stock de carbono e uma grandeza fisica (Mg C), nao um indicador de condicao. Alimenta a valorizacao monetaria dos servicos ecossistemicos (mercados de carbono), onde o valor absoluto importa, e nao um indice relativo.

**P: Posso replicar isto para o meu pais?**
R: Sim. Necessita de: (1) poligonos de extensao de mangais GMW 2020 para o seu local, (2) dados GEDI (de acesso gratuito no NASA LP DAAC), (3) niveis de referencia adequados a sua regiao, (4) os scripts R deste projecto (adaptaveis). A metodologia e inteiramente transferivel.

---

*Versao: 1.0*
*Data: 2026-03-29*
*Documentos complementares: MOZ_METODOLOGIA_SCEE_CE.md, MOZ_FICHA_PARTICIPANTE.md*
