@istest
public class apextestclass1 {
    @testsetup static void sampledata()
    {
        Food_Items__c samdata=new Food_Items__c ( Food_Item_Name__c='sam',Quantity__c='1',Cost_Per_KG__c=2,Image__c='abc');
        insert samdata;
        Cart__c samdatacart=new  Cart__c( FOOD_ITEM_NAME__c='sam',Quantity__c='1',Cost_Per_KG__c=2,Image__c='abc');
        insert samdatacart;
        
    }
   
    static testmethod void doDeletetest()
    {
        test.startTest();
        sampleclspro1 pp=new sampleclspro1();
        pp.cart();
        pp.getRecords();
        Cart__c samdatacart=[select id from Cart__c where FOOD_ITEM_NAME__c='sam'];
        pp.rId=samdatacart.id;
        pp.doDelete();
        test.stopTest();
    }
    static testmethod void myhometest()
    {
        test.startTest();
        cart__c ct0=new cart__c();
        pagereference pg =page.samplevfpro1;
        test.setCurrentPage(pg);
        Apexpages.StandardController controller =new Apexpages.StandardController(ct0);
        sampleclspro1 pp=new sampleclspro1();
        pp.home();
        test.stopTest();
    }
    static testmethod void paypagetest()
    {
        test.startTest();
        cart__c ct1=new cart__c();
        pagereference pg1 =page.paymentvf;
        test.setCurrentPage(pg1);
        Apexpages.StandardController controller =new Apexpages.StandardController(ct1);
        sampleclspro1 pp=new sampleclspro1();
        pp.paymentpage();
        test.stopTest();
    }
    static testmethod void cartpagetest()
    {
        test.startTest();
        cart__c ct2=new cart__c();
        pagereference pg2 =page.cartpage;
        test.setCurrentPage(pg2);
        Apexpages.StandardController controller =new Apexpages.StandardController(ct2);
        sampleclspro1 pp=new sampleclspro1();
        pp.cart();
        test.stopTest();
    }
    
    static testmethod void searchpagetest()
    {
        test.startTest();
        cart__c ct2=new cart__c();
         ct2.FOOD_ITEM_NAME__c='testdel';
        ct2.Cost_Per_KG__c=200;
        ct2.Quantity__c='2';
        insert ct2;
        Apexpages.StandardController controller =new Apexpages.StandardController(ct2);
        sampleclspro1 pp=new sampleclspro1();
        pp.searchkey='test';
        pp.Search();
        test.stopTest();
    }
    
      static testmethod void cleartest()
    {
        test.startTest();
        cart__c ct3=new cart__c();
        
        Apexpages.StandardController controller =new Apexpages.StandardController(ct3);
        sampleclspro1 pp=new sampleclspro1();
        pp.clear();
        pp.getdata();
        test.stopTest();
    }
    static testmethod void branchnamestest()
    {
        test.startTest();
        cart__c ct4=new cart__c();
        Branch__c brc=new Branch__c();
        brc.Name='Test';
        insert brc;
        Apexpages.StandardController controller =new Apexpages.StandardController(ct4);
        sampleclspro1 pp=new sampleclspro1();
       pp.getBranchNames();
        list<Branch__c> br =[select id from Branch__c];
        integer i=br.size();
        system.assertEquals(1, i);
        test.stopTest();
    }
    public static testMethod void method1(){
       // cart__c ct5= new cart__c();
        
         test.startTest();
    sampleclspro1 ff = new sampleclspro1();
       ff.getdata();
     
      ff.carts();
            
        test.stopTest();
        
    }

}