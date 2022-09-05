/* José Carlos Amo Perez Proyecto sql
 * script de consulta de los coches activos que hay en KeepCoding mostrando:
- Nombre modelo, marca y grupo de coches (los nombre de todos)
- Fecha de compra
- Matricula
- Nombre del color del coche
- Total kilómetros
- Nombre empresa que esta asegurado el coche
- Numero de póliza
 */

		
select  A.nombre_modelo, B.nombre_marca, C.nombre_grupo, D.fecha_compra, D.matricula, E.nombre_color, F.kilometros_tot, 
G.nombre_aseguradora, H.numero_poliza
from amoperez.modelos A, amoperez.marcas B, amoperez.vehiculos D, amoperez.grupos C, amoperez.colores E, amoperez.kilometros F, 
amoperez.aseguradoras G, amoperez.polizas H
where A.id_modelo = D.id_modelo and A.id_marca = B.id_marca and B.id_grupo = C.id_grupo and D.id_color = E.id_color
		and (D.id_vehiculo = F.id_vehiculo and F.proxima_lectura > now()) -- dos 'and' para mostrar solo ultima lectura de kilometraje
		and G.id_aseguradora = H.id_aseguradora 
		and (D.id_vehiculo = H.id_vehiculo and h.fecha_baja > now()) -- dos 'and' para mostrar solo ultima poliza en vigor
		and D.fecha_venta > now(); --- para ver solo los vehiculos activos (no los vendidso o dados de baja)
		
		