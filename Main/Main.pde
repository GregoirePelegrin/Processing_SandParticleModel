int size;
int spawnSpeed;
int spread;
IntList nextState;
IntList state;
boolean stable;

void setup(){
    size(600, 600);
    frameRate(60);

    size = 10;
    spawnSpeed = 10;
    spread = 5;
    nextState = new IntList();
    state = new IntList();
    stable = true;

    for(int y=0; y<height/size; y++){
        for(int x=0; x<width/size; x++){
            state.append(0);
            nextState.append(0);
        }
    }
}

void draw(){
    if(stable) for(int i=0; i<spawnSpeed; i++) drop();
    propagate();

    update();
    display();
}

void display(){
    for(int y=0; y<height/size; y++){
        for(int x=0; x<width/size; x++){
            noStroke();
            switch(state.get(int(y*width/size + x))){
                case 0:
                    fill(1, 24, 38);
                    break;
                case 1:
                    fill(2, 56, 89);
                    break;
                case 2:
                    fill(3, 101, 140);
                    break;
                case 3:
                    fill(4, 157, 191);
                    break;
                case 4:
                    fill(241, 242, 235);
                    break;
                default:
                    fill(241, 242, 235);
            }
            rect(x*size, y*size, size, size);
        }
    }
}
void drop(){
    int x = int(width/size/2 + randomGaussian() * spread);
    int y = int(height/size/2 + randomGaussian() * spread);
    while(!(0 <= x && x < width/size && 0 <= y && y < height/size)){
        x = (0 <= x && x < width/size) ? x : int(width/size/2 + randomGaussian() * spread);
        y = (0 <= y && y < height/size) ? y : int(height/size/2 + randomGaussian() * spread);
    }
    nextState.set(int(y*width/size + x), state.get(int(y*width/size + x)) + 1);
}
void propagate(){
    stable = true;
    for(int y=0; y<height/size; y++){
        for(int x=0; x<width/size; x++){
            if(state.get(int(y*width/size + x)) >= 4){
                stable = false;
                nextState.set(int(y*width/size + x), 0);
                if(x > 0) nextState.set(int(y*width/size + x-1), state.get(int(y*width/size + x-1)) + 1);
                if(x < width/size - 1) nextState.set(int(y*width/size + x+1), state.get(int(y*width/size + x+1)) + 1);
                if(y > 0) nextState.set(int((y-1)*width/size + x), state.get(int((y-1)*width/size + x)) + 1);
                if(y < height/size - 1) nextState.set(int((y+1)*width/size + x), state.get(int((y+1)*width/size + x)) + 1);
            }
        }
    }
}
void update(){
    for(int i=0; i<nextState.size(); i++){
        state.set(i, nextState.get(i));
    }
}