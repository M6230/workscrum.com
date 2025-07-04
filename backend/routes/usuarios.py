from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required
import uuid

usuarios_bp = Blueprint('usuarios', __name__)

# Mostrar usuarios (requiere token)
@usuarios_bp.route('/mostrar', methods=['GET'])
@jwt_required()
def showUsuarios():
    con = current_app.mysql.connection.cursor()
    con.execute("SELECT * FROM usuarios WHERE USU_ESTADO = 1")
    usuarios = con.fetchall()
    con.close()
    listado = []

    for usuario in usuarios:
        listado.append({
            "USU_ID": usuario[0],
            "USU_NOMBRE": usuario[1],
            "USU_APELLIDO": usuario[2],
            "USU_CORREO": usuario[3],
            "USU_ROL": usuario[4],
            "USU_ESTADO": usuario[5],
            "USU_UID": usuario[6],
            "USU_CONTRASENA": usuario[7]
        })
    return jsonify(listado)

# Registrar usuario (requiere token)
@usuarios_bp.route('/crear', methods=['POST'])
def createUsuario():
    campos_requeridos = ["USU_NOMBRE", "USU_APELLIDO", "USU_CORREO", "USU_ROL", "USU_CONTRASENA"]
    peticion = request.json
    faltantes = [x for x in campos_requeridos if x not in peticion]

    if faltantes:
        return jsonify({"mensaje": f"Faltan campos en la petición: {faltantes}"}), 400

    correo = peticion["USU_CORREO"]

    con = current_app.mysql.connection.cursor()
    con.execute("SELECT * FROM usuarios WHERE USU_CORREO = %s AND USU_ESTADO = 1", [correo])
    existente = con.fetchone()

    if existente:
        con.close()
        return jsonify({"mensaje": "Ya existe un usuario registrado con este correo"}), 409

    nombre = peticion["USU_NOMBRE"]
    apellido = peticion["USU_APELLIDO"]
    rol = peticion["USU_ROL"]
    estado = 1
    uid = uuid.uuid4()
    password = peticion["USU_CONTRASENA"]

    con.execute("""
        INSERT INTO usuarios (USU_NOMBRE, USU_APELLIDO, USU_CORREO, USU_ROL, USU_ESTADO, USU_uid, USU_CONTRASENA)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, [nombre, apellido, correo, rol, estado, uid, password])
    con.connection.commit()
    con.close()

    return jsonify({"mensaje": "Se ha registrado el usuario"}), 201


# Actualizar usuario (requiere token)
@usuarios_bp.route('/editar/<id>', methods=['PUT'])
@jwt_required()
def updateUsuario(id):
    campos_requeridos = ["USU_NOMBRE", "USU_APELLIDO", "USU_CORREO", "USU_ROL", "USU_CONTRASENA"]
    peticion = request.json
    faltantes = [x for x in campos_requeridos if x not in peticion]

    if faltantes:
        return jsonify({"mensaje": f"Faltan campos en la petición: {faltantes}"}), 400

    correo = peticion["USU_CORREO"]

    con = current_app.mysql.connection.cursor()
    con.execute("SELECT * FROM usuarios WHERE USU_CORREO = %s AND USU_id != %s AND USU_ESTADO = 1", [correo, id])
    existente = con.fetchone()

    if existente:
        con.close()
        return jsonify({"mensaje": "Otro usuario ya está registrado con este correo"}), 409

    nombre = peticion["USU_NOMBRE"]
    apellido = peticion["USU_APELLIDO"]
    rol = peticion["USU_ROL"]
    estado = 1
    uid = uuid.uuid4()
    password = peticion["USU_CONTRASENA"]

    con.execute("""
        UPDATE usuarios
        SET USU_NOMBRE = %s, USU_APELLIDO = %s, USU_CORREO = %s, USU_ROL = %s, USU_ESTADO = %s, USU_uid = %s, USU_CONTRASENA = %s
        WHERE USU_id = %s
    """, [nombre, apellido, correo, rol, estado, uid, password, id])
    con.connection.commit()
    con.close()

    return jsonify({"mensaje": "Se ha actualizado el usuario"})


# Eliminar usuario (requiere token)
@usuarios_bp.route('/eliminar/<id>', methods=['DELETE'])
@jwt_required()
def deleteUsuario(id):
    con = current_app.mysql.connection.cursor()

    con.execute("SELECT USU_ID FROM usuarios WHERE USU_ID = %s", [id])
    usuario = con.fetchone()

    if not usuario:
        return jsonify({"error": "Usuario no encontrado"}), 404

    con.execute("UPDATE usuarios SET USU_ESTADO = 0 WHERE USU_id = %s", [id])
    con.connection.commit()

    return jsonify({"mensaje": "Se ha eliminado el usuario"})
