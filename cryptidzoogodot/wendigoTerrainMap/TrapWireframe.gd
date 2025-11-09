extends MeshInstance3D

func _ready():
	var mesh = ImmediateMesh.new()
	var half_extents = Vector3(0.5, 0.5, 0.5)
	var thickness = 0.03  

	# corners
	var corners = [
		Vector3(-half_extents.x, -half_extents.y, -half_extents.z),
		Vector3( half_extents.x, -half_extents.y, -half_extents.z),
		Vector3(-half_extents.x,  half_extents.y, -half_extents.z),
		Vector3( half_extents.x,  half_extents.y, -half_extents.z),
		Vector3(-half_extents.x, -half_extents.y,  half_extents.z),
		Vector3( half_extents.x, -half_extents.y,  half_extents.z),
		Vector3(-half_extents.x,  half_extents.y,  half_extents.z),
		Vector3( half_extents.x,  half_extents.y,  half_extents.z)
	]

	var edges = [
		# Bottom
		[0, 1], [0, 2], [1, 3], [2, 3],
		# Top
		[4, 5], [4, 6], [5, 7], [6, 7],
		# sides
		[0, 4], [1, 5], [2, 6], [3, 7]
	]

	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_TRIANGLES)

	for edge in edges:
		var a = corners[edge[0]]
		var b = corners[edge[1]]
		var dir = (b - a).normalized()
		var up = Vector3.UP
		if abs(dir.dot(up)) > 0.9:
			up = Vector3.RIGHT
		var right = dir.cross(up).normalized() * thickness
		up = right.cross(dir).normalized() * thickness

		# Create a thin quad around the edge
		var v0 = a - right - up
		var v1 = a + right - up
		var v2 = b + right + up
		var v3 = b - right + up

		mesh.surface_add_vertex(v0)
		mesh.surface_add_vertex(v1)
		mesh.surface_add_vertex(v2)

		mesh.surface_add_vertex(v0)
		mesh.surface_add_vertex(v2)
		mesh.surface_add_vertex(v3)

	mesh.surface_end()
	self.mesh = mesh

	# glow
	var material = StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color(1, 0, 0)
	material.emission_enabled = true
	material.emission = Color(10, 0, 0)
	material.emission_energy_multiplier = 50.0
	set_surface_override_material(0, material)
