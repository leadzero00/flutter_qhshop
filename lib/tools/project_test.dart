class project_test{

  int x;
  int y;

  project_test({this.x,this.y});


  int getsubX(){
	  return this.x;
  }
  
  void setsubX(int x_axis)
  {
    x = x-x_axis;
  }

   int getsubY(){
	  return this.y;
  }
  
  void setsubY(int y_axis)
  {
    y = y_axis;
  }
}