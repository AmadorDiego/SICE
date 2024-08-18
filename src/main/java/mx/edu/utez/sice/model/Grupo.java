package mx.edu.utez.sice.model;

import java.util.ArrayList;

public class Grupo {

    private int id_grupo;
    private int grado;
    private String grupo; //Modifique de tipo char a tipo String
    private int id_periodo;
    private ArrayList<Usuario> alumnos;

    //Modifique de tipo char a tipo String
    public Grupo(int id_grupo, int grado, String grupo, int id_periodo, ArrayList<Usuario> alumnos) {
        this.id_grupo = id_grupo;
        this.grado = grado;
        //Modifique de tipo char a tipo String
        this.grupo = grupo;
        this.id_periodo = id_periodo;
        this.alumnos = alumnos;
    }

    public Grupo(){

    }
    public int getId_grupo() {
        return id_grupo;
    }

    public void setId_grupo(int id_grupo) {
        this.id_grupo = id_grupo;
    }

    public int getGrado() {
        return grado;
    }

    public void setGrado(int grado) {
        this.grado = grado;
    }

    //Modifique de tipo char a tipo String LOS GRUPOS
    public String getGrupo() {
        return grupo;
    }

    public void setGrupo(String grupo) {
        this.grupo = grupo;
    }

    public int getId_periodo() {
        return id_periodo;
    }

    public void setId_periodo(int id_periodo) {
        this.id_periodo = id_periodo;
    }

    public ArrayList<Usuario> getAlumnos() {
        return alumnos;
    }

    public void setAlumnos(ArrayList<Usuario> alumnos) {
        this.alumnos = alumnos;
    }
}
