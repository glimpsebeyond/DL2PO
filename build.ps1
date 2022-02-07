$pakPath = "D:\SteamLibrary\steamapps\common\Dying Light 2\ph\source\data3.pak" 
if(ls $pakPath){
7z u $pakPath .\data3.pakd\*
}else{
7z a -tzip $pakPath .\data3.pakd\*
}
