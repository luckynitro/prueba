// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract MiAgenciaGoogle {
    address public owner; // Dirección del propietario del contrato
    uint256 public costoCampaña; // Costo de una campaña publicitaria en wei

    struct Cliente {
        bool registrado; // Indica si el cliente está registrado
        uint256 saldo;   // Saldo del cliente en wei para pagar campañas
        // Otras propiedades del cliente como nombre, correo electrónico, etc.
    }

    mapping(address => Cliente) public clientes; // Almacena información del cliente

    event NuevaCampaña(address indexed cliente, uint256 costo);
    event PagoRecibido(address indexed cliente, uint256 cantidad);

    constructor(uint256 _costoCampaña) {
        owner = msg.sender;
        costoCampaña = _costoCampaña;
    }

    function registrarCliente() external {
        require(!clientes[msg.sender].registrado, "Cliente ya registrado");
        clientes[msg.sender] = Cliente(true, 0);
    }

    function realizarCampaña() external payable {
        require(clientes[msg.sender].registrado, "Cliente no registrado");
        require(msg.value >= costoCampaña, "Saldo insuficiente para la campaña");
        clientes[msg.sender].saldo += msg.value;
        emit NuevaCampaña(msg.sender, msg.value);
    }

    function pagarCampaña(address _cliente) external {
        uint256 saldoCliente = clientes[_cliente].saldo;
        require(saldoCliente > 0, "El cliente no tiene deudas pendientes");
        require(msg.sender == owner, "Solo el propietario puede realizar pagos");
        clientes[_cliente].saldo = 0;
        payable(_cliente).transfer(saldoCliente);
        emit PagoRecibido(_cliente, saldoCliente);
    }
}

