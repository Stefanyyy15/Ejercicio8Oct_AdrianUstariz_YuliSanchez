CREATE DATABASE IF NOT EXISTS UNIMINUTO;
USE UNIMINUTO;

-- Tablas independientes
CREATE TABLE IF NOT EXISTS Ciudades (
    Id_Ciudad INT PRIMARY KEY,
    Nombre VARCHAR(250) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Barrio (
    Id_Barrio INT PRIMARY KEY,
    Nombre VARCHAR(250) NOT NULL,
    Id_Ciudad INT,
    FOREIGN KEY (Id_Ciudad) REFERENCES Ciudades (Id_Ciudad)
);

CREATE TABLE IF NOT EXISTS Direccion (
    Id_Direccion INT PRIMARY KEY,
    Tipo_Calle VARCHAR(50) NOT NULL,
    Numero VARCHAR(50) NOT NULL,
    Complemento VARCHAR(50) NOT NULL,
    Id_Ciudad INT,
    Id_Barrio INT,
    FOREIGN KEY (Id_Ciudad) REFERENCES Ciudades (Id_Ciudad),
    FOREIGN KEY (Id_Barrio) REFERENCES Barrio (Id_Barrio)
);

CREATE TABLE IF NOT EXISTS Carreras (
    Id_Carrera INT PRIMARY KEY,
    Nombre VARCHAR(250) NOT NULL,
    Semestres INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Sisben (
    Id_Sisben INT PRIMARY KEY,
    Grupo VARCHAR(50) NOT NULL,
    Clasificacion INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Privada (
    Id_Privada INT PRIMARY KEY,
    Nombre VARCHAR(250) NOT NULL
);

CREATE TABLE IF NOT EXISTS Aulas (
    Id_Aula INT PRIMARY KEY,
    Nombre VARCHAR(50)
);

-- Tablas con dependencias
CREATE TABLE IF NOT EXISTS Estudiante (
    Id_Estudiante INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(255) UNIQUE,
    Fecha_Nacimiento DATE NOT NULL,
    Documento VARCHAR(50) NOT NULL,
    Semestre VARCHAR(3) NOT NULL,
    Modalidad ENUM('Nocturna', 'Diurna', 'Virtual'),
    Id_Direccion INT,
    Id_Carrera INT,
    FOREIGN KEY (Id_Direccion) REFERENCES Direccion (Id_Direccion),
    FOREIGN KEY (Id_Carrera) REFERENCES Carreras (Id_Carrera)
);

CREATE TABLE IF NOT EXISTS HistorialAcademico (
    Id_Historial INT PRIMARY KEY,
    Resultado_Icfes INT NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    Seguro ENUM('Sisben', 'Privada'),
    Fecha_Finalizacion DATE,
    Colegio VARCHAR(250) NOT NULL,
    Id_Estudiante INT,
    Id_Sisben INT,
    Id_Privada INT,
    FOREIGN KEY (Id_Estudiante) REFERENCES Estudiante (Id_Estudiante),
    FOREIGN KEY (Id_Sisben) REFERENCES Sisben (Id_Sisben),
    FOREIGN KEY (Id_Privada) REFERENCES Privada (Id_Privada)
);

CREATE TABLE IF NOT EXISTS Profesores (
    Id_Profesor INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Profesion VARCHAR(50) NOT NULL,
    Seguro ENUM('Sisben', 'Privada'),
    Id_Direccion INT,
    Id_Sisben INT,
    Id_Privada INT,
    FOREIGN KEY (Id_Direccion) REFERENCES Direccion (Id_Direccion),
    FOREIGN KEY (Id_Sisben) REFERENCES Sisben (Id_Sisben),
    FOREIGN KEY (Id_Privada) REFERENCES Privada (Id_Privada)
);

CREATE TABLE IF NOT EXISTS Cursos (
    Id_Cursos INT PRIMARY KEY,
    Nombre VARCHAR(250) NOT NULL,
    Creditos INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Horario (
    Id_Horario INT PRIMARY KEY,
    Dia ENUM('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'),
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    Id_Aula INT,
    FOREIGN KEY (Id_Aula) REFERENCES Aulas (Id_Aula)
);

-- Tablas de relación
CREATE TABLE IF NOT EXISTS CursoCarrera (
    Id_Cursos INT,
    Id_Carrera INT,
    PRIMARY KEY (Id_Cursos, Id_Carrera),
    FOREIGN KEY (Id_Cursos) REFERENCES Cursos (Id_Cursos),
    FOREIGN KEY (Id_Carrera) REFERENCES Carreras (Id_Carrera)
);

CREATE TABLE IF NOT EXISTS EstudianteCurso (
    Id_Estudiante INT,
    Id_Cursos INT,
    Id_Horario INT,
    PRIMARY KEY(Id_Estudiante, Id_Cursos, Id_Horario),
    FOREIGN KEY (Id_Estudiante) REFERENCES Estudiante (Id_Estudiante),
    FOREIGN KEY (Id_Cursos) REFERENCES Cursos (Id_Cursos),
    FOREIGN KEY (Id_Horario) REFERENCES Horario (Id_Horario)
);

CREATE TABLE IF NOT EXISTS AulaCurso (
    Id_Aula INT,
    Id_Cursos INT,
    PRIMARY KEY (Id_Aula, Id_Cursos),
    FOREIGN KEY (Id_Aula) REFERENCES Aulas (Id_Aula),
    FOREIGN KEY (Id_Cursos) REFERENCES Cursos (Id_Cursos)
);

CREATE TABLE IF NOT EXISTS ProfesoresCursos (
    Id_Profesor INT,
    Id_Cursos INT,
    PRIMARY KEY (Id_Profesor, Id_Cursos),
    FOREIGN KEY (Id_Profesor) REFERENCES Profesores (Id_Profesor),
    FOREIGN KEY (Id_Cursos) REFERENCES Cursos (Id_Cursos)
);