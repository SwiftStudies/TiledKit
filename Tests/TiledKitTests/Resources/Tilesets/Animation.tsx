<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.4" tiledversion="1.4.2" name="Animation" tilewidth="16" tileheight="16" tilecount="4" columns="2">
 <image source="../Images/4 Tiles.png" width="32" height="32"/>
 <tile id="0">
  <objectgroup draworder="index" id="2">
   <object id="1" x="7.92176" y="8.00534" width="5" height="5" rotation="45.5812"/>
   <object id="2" x="4.03964" y="3.00272" width="7.86123" height="5"/>
  </objectgroup>
 </tile>
 <tile id="1">
  <animation>
   <frame tileid="0" duration="1000"/>
   <frame tileid="1" duration="1000"/>
   <frame tileid="2" duration="1000"/>
   <frame tileid="3" duration="1000"/>
  </animation>
 </tile>
</tileset>
