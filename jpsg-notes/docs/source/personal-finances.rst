Personal Finances
=================


My Developed App in Rust - FINAJJ 
---------------------------------

**TODO**: 
* Learn to parse CSV data from Rust 
* Look how banks export credit card and normal account data 
* Develop simple arch with metrics, format, cli 


**Requirements**:
* Use a single JSON for configuration and major classification dictionary 
* Use addon JSON for classification dictionary of each month 
* Export a a new csv with my custom expenses data like classification and metrics 
* Expenses must be classified as: 

    * Fixa ou Variavel
    * Type: Farmacia, Alimentacao, Carro, Moradia, Lazer, Viagem, Outros

* Must support ITAU, CAIXA e NUBANK for now 
* Must supoort account extracs from normal account and credit card
* Must find the bank automatic 
* Store at least 6 month or 1 year of data 
* Must support adding new metrics easy 
* Must support expense/income balcklist for igonring 
* Must support adding new display information easy 
* Must suport these built in metrics: 

    * Quanto é gasto em gasto fixo e variavel no mes? 
    * Como o gasto é distribuido nos tipos principais no mês? 
    * Como o gasto é distribuido nos tipos principais no gasto fixo e variavel no mês?
    * Qual o fluxo de caixa? 
    * Qual a media de fluxo de caixa dos ultimos 6 meses? 
    * Qual a media de gasto dos ultimos 6 meses nos tipos principais?  
    * Qual a media de gasto dos ultimos 6 meses em gasto fixo e variavel? 

* Must support email notification at end of each month
* Must fetch data automatically from my google drive for extracts
 
        
