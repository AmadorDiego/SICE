package mx.edu.utez.sice.model;

public class Usuario {
    private int id_usuario;
    private String contrasena;
    private String correo_electronico;
    private boolean estado;
    private String nombre;

    public Usuario() {
    }

    public Usuario(int id_usuario, String contrasena, String correo_electronico, boolean estado, String nombre) {
        this.id_usuario = id_usuario;
        this.contrasena = contrasena;
        this.correo_electronico = correo_electronico;
        this.estado = estado;
        this.nombre = nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getCorreo_electronico() {
        return correo_electronico;
    }

    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
}