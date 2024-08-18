package mx.edu.utez.sice.model;

public class Tabla {

    private Grupo grupo;
    private DivisionAcademica divisionAcademica; //Cambie division por division academica
    private Carrera carrera;

    public Tabla(Grupo grupo, DivisionAcademica divisionAcademica, Carrera carrera) {
        this.grupo = grupo;
        this.divisionAcademica = divisionAcademica;
        this.carrera = carrera;
    }

    public Tabla() {
    }

    public Grupo getGrupo() {
        return grupo;
    }

    public void setGrupo(Grupo grupo) {
        this.grupo = grupo;
    }

    public DivisionAcademica getDivisionAcademica() {
        return divisionAcademica;
    }

    public void setDivisionAcademica(DivisionAcademica divisionAcademica) {
        this.divisionAcademica = divisionAcademica;
    }

    public Carrera getCarrera() {
        return carrera;
    }

    public void setCarrera(Carrera carrera) {
        this.carrera = carrera;
    }
}