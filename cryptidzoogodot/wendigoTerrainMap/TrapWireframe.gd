extends MeshInstance3D

func _ready():
	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)

	var s = 1.0
	var corners = [
		Vector3(-s, -s, -s), Vector3(s, -s, -s),
		Vector3(s, s, -s), Vector3(-s, s, -s),
		Vector3(-s, -s, s), Vector3(s, -s, s),
		Vector3(s, s, s), Vector3(-s, s, s)
	]

	var edges = [
		[0,1],[1,2],[2,3],[3,0],
		[4,5],[5,6],[6,7],[7,4],
		[0,4],[1,5],[2,6],[3,7]
	]

	for e in edges:
		mesh.surface_add_vertex(corners[e[0]])
		mesh.surface_add_vertex(corners[e[1]])

	mesh.surface_end()

	self.mesh = mesh
