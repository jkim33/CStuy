import java.util.*;
import java.io.*;

public class Reader{
    public Reader(){
    }
    public void Sentence(String filename){
	HashMap<String, ArrayList<String>> words = new HashMap<>();
	ArrayList<String> passage = new ArrayList<>();
	ArrayList<String> startWords = new ArrayList<>();
	try{
	    File f = new File(filename);
	    Scanner in = new Scanner(f);
	    while (in.hasNext()){
		String line = in.nextLine();
		if(line.length() > 0){
		    line = line.replace("\t","").replace("\n","");
		    String[] split = line.split(" ");
		    for(int i=0; i<split.length; i++){
			if(!words.containsKey(split[i])){
			    words.put(split[i], new ArrayList<>());
			}
			passage.add(split[i]);
			if(split[i].charAt(0) >= 'A' && split[i].charAt(0) <= 'Z'){
			    startWords.add(split[i]);
			}
		    }
		}
	    }
	    for(int i=0; i<passage.size() - 1; i++){
		words.get(passage.get(i)).add(passage.get(i+1));
	    }
	}catch(FileNotFoundException e){
	    System.out.println("Error: File not found: " + filename);
	    System.exit(1);
	}
	String sentence = "";
	String word = startWords.get((int)(Math.random() * startWords.size()));
	boolean go = true;
	int sentences = 0;
	while(go){
	    sentence += word + " ";
	    if(word.charAt(word.length() - 1) == '.' || word.charAt(word.length() - 1) == '!' || word.charAt(word.length() - 1) == '?'){
		if(sentences == 3){
		    go = false;
		}else{
		    sentences++;
		    word = startWords.get((int)(Math.random() * startWords.size()));
		}
	    }else{
		try{
		word = words.get(word).get((int)(Math.random() * words.get(word).size()));
		}
		catch (Exception e) {
		    break;
		}
	    }
	}
	System.out.println(sentence);
	
    }
}
