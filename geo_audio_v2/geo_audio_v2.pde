import com.getflourish.stt.*;
import com.google.gson.annotations.*;
import com.google.gson.*;
import com.google.gson.internal.*;
import com.google.gson.reflect.*;
import com.google.gson.stream.*;
import javaFlacEncoder.*;
import ddf.minim.*;

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

//todo 
//find a good library for pseech to text
//https://forum.processing.org/two/discussion/158/#Comment_372
//and
//the google api seem like the best bets

//todo setup the unfolding maps to display maps stuff (already imported)

STT stt;

String def = "didn't catch that.";

void setup()
{
  size(800, 800);
  stt = new STT(this, false);
  stt.enableDebug();
  stt.setLanguage("en");
  stt.enableAutoRecord();
  
  textFont(createFont("Arial", 24));
}

void draw()
{
  background(0);
  text(def, mouseX, mouseY);
  
}

void transcribe(String phrase, float confidence)
{
   println(phrase);
   def = phrase;
  
}
