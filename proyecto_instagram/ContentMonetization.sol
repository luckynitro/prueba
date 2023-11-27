// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContentMonetization {

    struct Imagen {
        address propietario;
        string ruta;
        bool monetizable;
        uint256 recompensa;
        uint256 precio;
    }

    mapping(uint256 => Imagen) public imagenes;
    uint256 public totalImagenes;

    mapping(address => uint256[]) public imagenesDelUsuario;
    mapping(address => uint256) public recompensasDelUsuario;

    event NuevaImagenCargada(address indexed propietario, uint256 indexed idImagen, string ruta);
    event MonetizacionActivada(uint256 indexed idImagen);
    event MonetizacionDesactivada(uint256 indexed idImagen);
    event RecompensaOtorgada(address indexed seguidor, uint256 cantidad);
    event PagoRecibido(address indexed marca, uint256 indexed idImagen, uint256 monto);

    modifier soloPropietario(uint256 idImagen) {
        require(imagenes[idImagen].propietario == msg.sender, "No eres el propietario de la imagen");
        _;
    }

    function subirImagen(string memory ruta) public {
        uint256 idImagen = totalImagenes + 1;
        imagenes[idImagen] = Imagen(msg.sender, ruta, true, 0, 0);
        totalImagenes++;
        imagenesDelUsuario[msg.sender].push(idImagen);

        emit NuevaImagenCargada(msg.sender, idImagen, ruta);
    }

    function activarMonetizacion(uint256 idImagen) public soloPropietario(idImagen) {
        imagenes[idImagen].monetizable = true;
        emit MonetizacionActivada(idImagen);
    }

    function desactivarMonetizacion(uint256 idImagen) public soloPropietario(idImagen) {
        imagenes[idImagen].monetizable = false;
        emit MonetizacionDesactivada(idImagen);
    }

    function otorgarRecompensa(address seguidor, uint256 cantidad) internal {
        recompensasDelUsuario[seguidor] += cantidad;
        emit RecompensaOtorgada(seguidor, cantidad);
    }

    function recompensarSeguidores(uint256 idImagen, address[] memory seguidores, uint256 cantidadPorSeguidor) public soloPropietario(idImagen) {
        for (uint256 i = 0; i < seguidores.length; i++) {
            otorgarRecompensa(seguidores[i], cantidadPorSeguidor);
        }
    }

    function establecerPrecioImagen(uint256 idImagen, uint256 precio) public soloPropietario(idImagen) {
        imagenes[idImagen].precio = precio;
    }

    function comprarImagen(uint256 idImagen) public payable {
        require(imagenes[idImagen].monetizable, "La imagen no está disponible para la compra");
        require(msg.value >= imagenes[idImagen].precio, "Monto insuficiente para comprar la imagen");

        imagenes[idImagen].propietario.transfer(msg.value);
        emit PagoRecibido(msg.sender, idImagen, msg.value);
    }

    function obtenerRecompensaTotal() public view returns (uint256) {
        return recompensasDelUsuario[msg.sender];
    }

    // ... Puedes seguir añadiendo más funciones según tus necesidades.

}
