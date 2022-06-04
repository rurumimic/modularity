package framework;

import fastjsonlib.FastJson;

public class MainBad {
    public static void main(String[] args) {
        FastJson fastJson = new FastJson(); // NoClassDefFoundError
        System.out.println(fastJson);
    }
}
