Table data;
PImage map;

void setup(){
  size(1000, 900);
  noStroke();
  
  map = loadImage("philly_map.png");
  data = loadTable("all_philly_healthcare.csv", "header");
}

void draw(){
  background(218, 237, 254);
  tint(170);
  map.resize(0, 860);
  image(map, 30, 20);
   
  int incomeFactor, mortalityFactor, disabilityFactor, mentalFactor, obesityFactor, diabetesFactor;
  int activeRow;
  int xpos, ypos;
  int offsetNear, offsetFar;
  
  //check mouse position for hover
  if(mouseX > 300 && mouseX < 400 && mouseY > 550 && mouseY < 650){
    activeRow = 0;
  }
  else if(mouseX > 130 && mouseX < 230 && mouseY > 220 && mouseY < 320){
    activeRow = 1; 
  }
  else if(mouseX > 250 && mouseX < 350 && mouseY > 700 && mouseY < 800){
    activeRow = 2; 
  }
  else if(mouseX > 650 && mouseX < 750 && mouseY > 100 && mouseY < 200){
    activeRow = 3; 
  }
  else if(mouseX > 500 && mouseX < 600 && mouseY > 280 && mouseY < 380){
    activeRow = 4; 
  }
  else if(mouseX > 420 && mouseX < 520 && mouseY > 430 && mouseY < 530){
    activeRow = 5; 
  }
  else if(mouseX > 300 && mouseX < 400 && mouseY > 250 && mouseY < 350){
    activeRow = 6; 
  }
  else if(mouseX > 70 && mouseX < 170 && mouseY > 700 && mouseY < 800){
    activeRow = 7; 
  }
  else if(mouseX > 110 && mouseX < 210 && mouseY > 520 && mouseY < 620){
    activeRow = 8; 
  }
  else if(mouseX > 230 && mouseX < 330 && mouseY > 400 && mouseY < 500){
    activeRow = 9;
  }
  
  else{
    activeRow = -1;
  }
  
  popup(activeRow);
  
  for(int i = 0; i < 10; i++){
    
    if(i == 0){ //center city
      xpos = 350;
      ypos = 600;
    }
    else if(i == 1){ //northwest
      xpos = 180;
      ypos = 270;
    }
    else if(i == 2){ //south
      xpos = 300;
      ypos = 750;
    }
    else if(i == 3){ //far northeast
      xpos = 700;
      ypos = 150;
    }
    else if(i == 4){ //lower northeast
      xpos = 550;
      ypos = 330;
    }
    else if(i == 5){ //river wards
      xpos = 470;
      ypos = 480;
    }
    else if(i == 6){ //far north
      xpos = 350;
      ypos = 300;
    }
    else if(i == 7){ //southwest
      xpos = 120;
      ypos = 750;
    }
    else if(i == 8){ //west
      xpos = 160;
      ypos = 570;
    }
    else if(i == 9){ //north
      xpos = 280;
      ypos = 450;
    }
    else{
      xpos = -100;
      ypos = -100;
    }
    
    TableRow currRow = data.getRow(i);
    if (activeRow == i){ //larger circles on hover
      incomeFactor = 500;
      mortalityFactor = 9;
      disabilityFactor = 6;
      mentalFactor = 6;
      obesityFactor = 3;
      diabetesFactor = 8;
      
      offsetNear = 45;
      offsetFar = 70;
      
    }
    else{ //default values
      incomeFactor = 700;
      mortalityFactor = 12;
      disabilityFactor = 4;
      mentalFactor = 4;
      obesityFactor = 2;
      diabetesFactor = 6;
      
      offsetNear = 30;
      offsetFar = 50;
    }
    
    //income
    int income = currRow.getInt("Median Income");
    fill(37, 206, 247);
    circle(xpos, ypos, int(income/incomeFactor));
    
    //mortality rate
    float mortality = currRow.getFloat("Mortality Rate");
    fill(60, 200);
    circle(xpos-offsetNear, ypos+offsetFar, int(mortality/mortalityFactor));
    
    //disability rate
    float disability = currRow.getFloat("Disability Rate");
    fill(33, 118, 210, 200);
    circle(xpos+offsetNear, ypos+offsetFar, int(disability*disabilityFactor));
    
    //mental health rate
    float mental = currRow.getFloat("Mental Health Rate");
    fill(88, 192, 77, 200);
    circle(xpos, ypos-offsetFar, int(mental*mentalFactor));
    
    //obesity rate
    float obesity = currRow.getFloat("Obesity Rate");
    fill(243, 198, 19, 200);
    circle(xpos-offsetFar, ypos, int(obesity*obesityFactor));
    
    //diabetes rate
    float diabetes = currRow.getFloat("Diabetes Rate");
    fill(231, 133, 135, 200);
    circle(xpos+offsetFar, ypos, int(diabetes*diabetesFactor));
  }
  
  //legend
  fill(37, 206, 247);
  circle(590, 634, 25);
  
  fill(60);
  circle(590, 674, 25);
  
  fill(33, 118, 210);
  circle(590, 714, 25);
  
  fill(88, 192, 77);
  circle(590, 754, 25);
  
  fill(243, 198, 19);
  circle(590, 794, 25);
 
  fill(231, 133, 135);
  circle(590, 834, 25);
  
  fill(0);
  textSize(18);
  text("Median Household Income", 620, 640);
  text("Mortality Rate per 100,000", 620, 680);
  text("Disability Rate", 620, 720);
  text("Poor Mental Health 14+ Days", 620, 760);
  text("Obesity Prevalence", 620, 800);
  text("Diabetes Prevalence", 620, 840);
}

void popup(int region){
  if(region == -1){
    return;
  }
  
  TableRow currRow = data.getRow(region);
  fill(255, 0, 0);
  
  //label
  textSize(22);
  String labelText = currRow.getString("Region");
  text(labelText, 620, 600);
  
  //income
  textSize(18);
  String income = currRow.getString("Median Income");
  String incomeText = "$" + income.substring(0, 2) + "," + income.substring(2, 5);
  text(incomeText, 860, 640);
  
  //mortality
  String mortalityText = currRow.getString("Mortality Rate");
  text(mortalityText, 860, 680);
  
  //disability
  String disabilityText = currRow.getString("Disability Rate") + "%";
  text(disabilityText, 860, 720);
  
  //mental health
  String mentalText = currRow.getString("Mental Health Rate") + "%";
  text(mentalText, 860, 760);
  
  //obesity
  String obesityText = currRow.getString("Obesity Rate") + "%";
  text(obesityText, 860, 800);
  
  //diabetes
  String diabetesText = currRow.getString("Diabetes Rate") + "%";
  text(diabetesText, 860, 840);
}
