package mx.edu.utez.sice.model;

public class Usuario {
    private int id_usuario;
    private String nombre_usuario;
    private String apellido_usuario;
    private String correo_electronico;
    private String contrasena;
    private boolean estado;
    private String fecha_registrado;
    private String codigo;
    private int id_tipo_usuario;
    private int id_carrera;

    public Usuario() {
    }
    //campo de carrera exclusivo para alumno
    public Usuario(int id_usuario, String nombre_usuario, String apellido_usuario, String correo_electronico, String contrasena, boolean estado, String fecha_registrado, String codigo, int id_tipo_usuario, int id_carrera) {
        this.id_usuario = id_usuario;
        this.nombre_usuario = nombre_usuario;
        this.apellido_usuario = apellido_usuario;
        this.correo_electronico = correo_electronico;
        this.contrasena = contrasena;
        this.estado = estado;
        this.fecha_registrado = fecha_registrado;
        this.codigo = codigo;
        this.id_tipo_usuario = id_tipo_usuario;
        this.id_carrera = id_carrera;
    }

    //exclusivo para docente, profesor o ambos
    public Usuario(int id_usuario, String nombre_usuario, String apellido_usuario, String correo_electronico, String contrasena, boolean estado, String fecha_registrado, String codigo, int id_tipo_usuario) {
        this.id_usuario = id_usuario;
        this.nombre_usuario = nombre_usuario;
        this.apellido_usuario = apellido_usuario;
        this.correo_electronico = correo_electronico;
        this.contrasena = contrasena;
        this.estado = estado;
        this.fecha_registrado = fecha_registrado;
        this.codigo = codigo;
        this.id_tipo_usuario = id_tipo_usuario;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getNombre_usuario() {
        return nombre_usuario;
    }

    public void setNombre_usuario(String nombre_usuario) {
        this.nombre_usuario = nombre_usuario;
    }

    public String getApellido_usuario() {
        return apellido_usuario;
    }

    public void setApellido_usuario(String apellido_usuario) {
        this.apellido_usuario = apellido_usuario;
    }

    public String getCorreo_electronico() {
        return correo_electronico;
    }

    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public String getFecha_registrado() {
        return fecha_registrado;
    }

    public void setFecha_registrado(String fecha_registrado) {
        this.fecha_registrado = fecha_registrado;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public int getId_tipo_usuario() {
        return id_tipo_usuario;
    }

    public void setId_tipo_usuario(int id_tipo_usuario) {
        this.id_tipo_usuario = id_tipo_usuario;
    }

    public int getId_carrera() {
        return id_carrera;
    }

    public void setId_carrera(int id_carrera) {
        this.id_carrera = id_carrera;
    }
}