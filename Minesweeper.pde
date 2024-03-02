import de.bezier.guido.*;
public final static int NUM_ROWS = 15;
public final static int NUM_COLS = 15;
public final static int NUM_MINES = 80;
public boolean davyn = true;
private MSButton[][] buttons; 
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); 

void setup ()
{
    size(390, 400);
    textAlign(CENTER,CENTER);
    
   
    Interactive.make( this );
    
   buttons = new MSButton[NUM_ROWS][NUM_COLS];
   for(int r = 0; r < NUM_ROWS; r++){
     for(int c = 0; c < NUM_COLS; c++){
       buttons[r][c] = new MSButton(r, c);
     }
   }
    
    
    
    setMines();
}
public void setMines()
{
  for(int m = 0; m < NUM_MINES; m++) {
    int row = (int)(Math.random() * NUM_ROWS);
    int col = (int)(Math.random() * NUM_COLS);
    if(!mines.contains(buttons[row][col])) {
      mines.add(buttons[row][col]);
    }
    
  }
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
  int sum = 0;
     for(int r = 0; r < NUM_ROWS; r++){
     for(int c = 0; c < NUM_COLS; c++){
       if(mines.contains(buttons[r][c]) && buttons[r][c].isFlagged())
       sum++;
     }
     }
     if(sum == NUM_MINES)
     return true;
     else
    return false;
}
public void displayLosingMessage()
{
  for(int i = 0; i < 15 ;i++){
    for(int j = 0; j < 15 ;j++){
    buttons[i][j].myLabel = "L";
  }
  }
  for(int i = 0; i < NUM_ROWS; i++){
    for(int j = 0; j < NUM_COLS; j++){
      if(mines.contains(buttons[i][j]))
      buttons[i][j].clicked = true;
    }
  }
}
public void displayWinningMessage()
{
    for(int i = 0; i < 5 ;i++){
       for(int j = 0; j < 5 ;j++){
      buttons[i][j].myLabel = "W";
    }
    }
}
public boolean isValid(int r, int c)
{
  return(r >= 0 && c >= 0 && r < NUM_ROWS && c < NUM_COLS);
}
public int countMines(int row, int col)
{
    int numMines = 0;
for(int r = row-1; r<=row+1; r++){
    for(int c = col-1; c<=col+1; c++){
      if(isValid(r,c) && mines.contains(buttons[r][c]))
        numMines++;
    }
  }
 
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); 
    }

    
    public void mousePressed () 
    {
      if(davyn){
        if(mines.contains(this) || countMines(myRow, myCol) > 0){
        buttons = new MSButton[NUM_ROWS][NUM_COLS];
        for(int r = 0; r < NUM_ROWS; r++){
     for(int c = 0; c < NUM_COLS; c++){
       buttons[r][c] = new MSButton(r, c);
     }
   }
   mines = new ArrayList <MSButton>();
   setMines();
   buttons[myRow][myCol].mousePressed();
        }
   else{
     davyn = false;
   }
      }
      
        clicked = true;
        if(mouseButton == RIGHT){
          if(flagged == true){
            flagged = false;
            clicked = false;
          }
          if(flagged == false){
            flagged = true;
          }
        } 
        else if (mines.contains(this)){
          displayLosingMessage();
        }
        else if (countMines(myRow, myCol) > 0){
          myLabel = countMines(myRow, myCol) + "";
        }
        else{
          for(int r = myRow - 1; r <= myRow + 1; r++){
          for(int c = myCol - 1; c <= myCol + 1; c++){
            if(isValid(r,c) && !buttons[r][c].clicked)
            buttons[r][c].mousePressed();
            
          }
          }
        }
        
      
        
        
    }
    public void draw () 
    {    
        if (flagged )
            fill(0);
       else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
            
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
  public void hasBeenCLicked(){
    
  }
