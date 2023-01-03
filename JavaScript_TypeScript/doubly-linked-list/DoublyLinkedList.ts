class DoublyLnkedList{
  private head : Node;
  private tail : Node;
 
  private size : number;
 
  constructor()
  {
    this.head = null;
    this.tail = null;
    this.size = 0;
  }
 
  public getFirst(): any
  {
    return this.head.value;  
  }
 
  public getLast(): any
  {
     return this.tail.value;
  }
 
  public push(value : any)
  {
    let temp = new Node();
    temp.next = null;
    temp.prev = this.tail;
    temp.value = value;
   
    this.tail.next = temp;
    this.tail = temp;
    this.size++;
   
  }
 
  public pop()
  {
    this.tail = this.tail.prev;
    this.tail.next = null;
    this.size--;
  }
 
  public unshift(value : any)
  {
    let temp = new Node();
    temp.next = this.head;
    temp.prev = null;
    temp.value = value;
   
    this.head.prev = temp;
   
    this.head = temp;
   
    this.size++;
   
  }
  public shift()
  {
    this.head = this.head.next;
    this.head.prev = null;
    this.size--;
  }
 
 
 
}
