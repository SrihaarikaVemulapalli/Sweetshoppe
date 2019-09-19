public  class paymentclass   {
   public string pid{set;get;}
     //public list<cart__c> total1 {get;set;}
    
    public list<Payment__c> records1{set;get;}
    private ApexPages.StandardController controller;
    Payment__c request;
    public paymentclass(ApexPages.StandardController controller)
    {
        this.controller = controller;
        records1=[select id,name from Payment__c where name=:pid];
        
    }
    public pagereference pay()
    {
     
        system.PageReference sp =  controller.save();
        
       
        //controller.save();
        String bid = String.valueof(sp).remove('System.PageReference[/').remove(']');
        records1=[select id,Customer_Name__c,Name from Payment__c WHERE id=:bid];
        
        system.debug(records1);
           
       List<Cart__c> cartList = [Select id,FOOD_ITEM_NAME__c,Image__c,Cost_Per_KG__c from cart__c];
       List<Orders1__c> oList = New List<Orders1__c>();
       for(Cart__c cartOrder : cartList){
           Orders1__c oOrder = New Orders1__c();
           oOrder.Food_Item_Name__c =  cartOrder.Food_Item_Name__c;
           //oOrder.Cost_Per_KG__c =  cartOrder.Cost_Per_KG__c;
           oOrder.Image__c =  cartOrder.Image__c;
           //oOrder.Quantity__c =  cartOrder.Quantity__c;
       
           oList.add(oOrder);
       }
       Insert oList;
       delete cartList;
         pagereference k=new pagereference('/apex/orderspage');
        return k;
           }
    }