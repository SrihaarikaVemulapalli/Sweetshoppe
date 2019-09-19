public class sampleclspro1 {
    
    public list<Food_Items__c> ab{get;set;}
    // public list<Payment__c> pd{get;set;}
    // public list <Cart__c> Records {get;set;}
    // public list<Cart__c> oab{get;set;}
    public string searchkey{get;set;}
    public String accId{get;set;}
    //  public String abcId{get;set;}
    public string q;
    //public Integer subtotal;
    public Integer cartnums{set;get;}
    public list<cart__c> items{set;get;}
    public boolean flag{get;set;}
    //public boolean flag1{get;set;}
    public id rId{get;set;}
    
    //public Integer totval {get;set;}
    public object sumamount{set;get;}
    
    public decimal Total_cost{set;get;}
    //public String amount{get; set;}
    
    cart__c delDlt = new cart__c();
    
    //public Integer co{get;set;}
    
    public sampleclspro1(){
        flag=false;
        Total_cost=0;
        cartnums=[select count() from cart__c];
        AggregateResult[] groupedResults = [SELECT SUM(Total_Cost__c)aver FROM Cart__c ];
        sumamount = groupedResults[0].get('aver');
    }
    public PageReference doDelete() {
        delDlt=[select id,FOOD_ITEM_NAME__c,Image__c,Cost_Per_KG__c from cart__c where id =:rId];
        delete delDlt;
        cartnums=[select count() from cart__c];
        pagereference pg=new pagereference('/apex/cartpage');
        return pg;
        
    }
    
    List<cart__c> lstdlt = new List<cart__c>();
    public List<cart__c> getRecords() {
        lstdlt =[select id,FOOD_ITEM_NAME__c,Image__c,Total_Cost__c,Cost_Per_KG__c,Quantity__c from cart__c];
        return lstdlt;
        
    }
    public pagereference home()
    {
        cartnums=[select count() from cart__c];
        pagereference pp=new pagereference('/apex/samplevfpro1');
        return pp;
    }
    
    
    public pagereference paymentpage()
    {
        pagereference py=new pagereference('/apex/paymentvf');
        return py;
    }
    
    public pagereference cart(){
        flag=true;        
        items=[select id,FOOD_ITEM_NAME__c,Image__c,Cost_Per_KG__c,Total_Cost__c,Quantity__c from Cart__c];
        for(cart__c carttotal:items){
            Total_cost=Total_cost+carttotal.Total_Cost__c;
        }
        
        pagereference pg=new pagereference('/apex/cartpage');
        return pg;
    }
    
    
    
    
    
    //global search...
    Public void Search()
    {
        flag=false;
        
        q='select Name,Cost_Per_KG__c,Food_Item_Name__c,Image__c,Quantity__c from Food_Items__c ';
        
        if((searchkey!=null && searchkey!=''))
        {
            q = q+' where Food_Item_Name__c like \'%'+searchkey+'%\'';
        }
        ab= database.query(q);
        
    }
    //clear near void search
    public void clear()
    {
        searchkey=null;
        ab=null;
        flag=false;
        
    }
    
    //picklist for branch
    public List<selectOption> getBranchNames()  
    {
        List<selectOption> options=new List<selectOption>();
        for(Branch__c b : [select name from Branch__c])
        {
            options.add(new selectOption(b.name,b.name));
        }
        return options;
    }
    
    public void getdata(){       
        flag=false;
        
        ab=[select Name,Cost_Per_KG__c,Food_Item_Name__c,Image__c,Quantity__c from Food_Items__c] ;    
        //  system.debug('list value'+ab);
        
    }
    
    //cart
    public void carts(){
        flag=false;  
        
        List<Food_Items__c> FoodItemList = [select id,Cost_Per_KG__c,Food_Item_Name__c,Image__c,Quantity__c from Food_Items__c where id =:accId];
        List<Cart__c> cartUpdateList = New List<Cart__c>();
        List<Cart__c> cartInsertList = New List<Cart__c>();
        List<Cart__c> existingCartList = [select id,FOOD_ITEM_NAME__c,Image__c,Cost_Per_KG__c,Total_Cost__c,Quantity__c from Cart__c];
        set<String> existingFIName = New set<String>();
        Map<String,Cart__c> existingCartsMap = new Map<String,Cart__c>();
        for(Cart__c ec:existingCartList){
            existingFIName.add(ec.FOOD_ITEM_NAME__c);  
            existingCartsMap.put(ec.FOOD_ITEM_NAME__c,ec);
        }
        for(Food_Items__c prodOrder : ab){
            if(prodOrder.Quantity__c==null)
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR ,'Quantity Should not be None!!'));
                        
                    }
            else{
            if(accId==prodOrder.Id ){
                Cart__c cartOrder = New Cart__c();
                if(existingFIName.contains(prodOrder.Food_Item_Name__c)){ 
                    cartOrder.Id = existingCartsMap.get(prodOrder.Food_Item_Name__c).Id;
                    cartOrder.FOOD_ITEM_NAME__c =  prodOrder.Food_Item_Name__c;
                    cartOrder.Cost_Per_KG__c =  prodOrder.Cost_Per_KG__c;
                    cartOrder.Image__c =  prodOrder.Image__c;
                    if(existingCartsMap.get(prodOrder.Food_Item_Name__c).quantity__c!=null)
                        cartOrder.Quantity__c =  String.valueof(Integer.valueOf(existingCartsMap.get(prodOrder.Food_Item_Name__c).quantity__c)+Integer.valueOf(prodOrder.Quantity__c));
                    else   
                    {
                        cartOrder.Quantity__c =  String.valueof(prodOrder.Quantity__c);
                        
                    }
                    
                    
                    
                    
                    cartUpdateList.add(cartOrder);
                }else{
                    
                    cartOrder.FOOD_ITEM_NAME__c =  prodOrder.Food_Item_Name__c;
                    cartOrder.Cost_Per_KG__c =  prodOrder.Cost_Per_KG__c;
                    cartOrder.Image__c =  prodOrder.Image__c;
                    cartOrder.Quantity__c =  prodOrder.Quantity__c;
                    
                    cartInsertList.add(cartOrder);
                    
                }
            }
            }
        }
        if(cartInsertList.size()>0){
            Insert cartInsertList;
        }
        if(cartUpdateList.size()>0){
            Update cartUpdateList;
        }
        cartnums=[select count() from cart__c];
        pagereference redirect = new PageReference('/apex/samplevfpro1');
    }
    
    
    
    
    
}