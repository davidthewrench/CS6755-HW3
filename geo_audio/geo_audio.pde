//https://davidthewrench.github.io/Audio_recording/

import processing.sound.*;

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;

import websockets.*;

WebsocketServer socket;

String phrase = "";

UnfoldingMap map;

ArrayList<geoLocate> locations = new ArrayList<geoLocate>();
ArrayList<SoundFile> sounds = new ArrayList<SoundFile>();

boolean stopFlag = false;

void setup() {
  socket = new WebsocketServer(this, 1337, "/p5websocket");
  
  
  size(1200, 900, P2D);
  map = new UnfoldingMap(this);
  
  MapUtils.createDefaultEventDispatcher(this, map);
  
  locations.add(new geoLocate("Florida", 27.6648, -81.5158));
  locations.add(new geoLocate("Texas", 31.9686, -99.9018));
  locations.add(new geoLocate("Tokyo", 35.6895, 139.6917));
  //locations.add(new geoLocate("Italy", 7, 3));
 
  
  sounds.add(new SoundFile(this, "6 - Ambience - Sea on Shingle.wav"));
  sounds.add(new SoundFile(this, "19 - Foley - Horse gallop on dirt constantly then stop.wav"));
  sounds.add(new SoundFile(this, "9 - Ambience - Traffic- busy and steady.wav"));
  //sounds.add(new SoundFile(this, "6 - Ambience - Sea on Shingle.wav"));
  
  textFont(createFont("Arial", 24));
  
}

void draw() {
  background(0);
  for(int i = 0; i < locations.size(); i++)
  {
    if(phrase.contains("stop"))
    {
      stopFlag = true;
    }
    geoLocate temp = locations.get(i);
    map.addMarker(temp.getMark());
    
    if(phrase.contains(temp.getName()))
    {
       temp.select();
    }
    
    if(temp.isSelected() == true)
    {
       temp.increase();
       if(sounds.get(i).isPlaying() == 0)
         sounds.get(i).play();
    }
    else
    {
      if(sounds.get(i).isPlaying() == 1)
         sounds.get(i).stop();
    } 
  }
  if(stopFlag == true)
  {
    for(int i = 0; i < locations.size(); i++)
    {
      locations.get(i).deselect();
    }
    stopFlag = false; 
  }
  
  map.draw();
}

void webSocketServerEvent(String msg){
 println(msg);
 phrase = msg;
}

class geoLocate extends Location
{
   String name;
   boolean isSelected = false;
   int time = 0;
   int max = 1000;
   
   SimplePointMarker m;
   
   geoLocate()
   {
     super(0, 0);
   }
   geoLocate(String temp, float a, float b)
   {
     super(a, b);
     name = temp;
     m = new SimplePointMarker(this);
     m.setHidden(true);
   }
   
   String getName()
   {
     return name;
   }
   
   boolean isSelected()
   {
      return isSelected; 
   }
   
   SimplePointMarker getMark()
   {
      return m; 
   }
   
   void increase()
   {
      if(isSelected == true)
        time++;
      if(time > max)
      {
        this.deselect();
      }
   }
   
   void select()
   {
      if(isSelected == true)
        time = 0;
      
      m.setHidden(false);  
      isSelected = true; 
   }
   void deselect()
   {
      time = 0;
      m.setHidden(true);
      isSelected = false;
   }
}