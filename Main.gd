 extends Node3D

func _ready():
	print("Echo Lab - Main scene ready")
	_create_environment()
	_create_lab_floor()
	_create_walls()
	_create_lighting()
	_create_camera()
	_load_robot()

func _create_environment():
	var world_env = WorldEnvironment.new()
	var env = Environment.new()
	var sky = Sky.new()
	var sky_material = ProceduralSkyMaterial.new()
	sky_material.sky_top_color = Color(0.95, 0.95, 1.0)
	sky_material.sky_horizon_color = Color(0.8, 0.8, 0.9)
	sky_material.ground_bottom_color = Color(0.1, 0.1, 0.1)
	sky_material.ground_horizon_color = Color(0.5, 0.5, 0.6)
	sky.sky_material = sky_material
	env.background_mode = Environment.BG_SKY
	env.sky = sky
	env.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	env.ambient_light_energy = 0.8
	world_env.environment = env
	add_child(world_env)

func _create_lab_floor():
	var ground = MeshInstance3D.new()
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(30, 30)
	ground.mesh = plane_mesh
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.95, 0.95, 0.95)
	material.roughness = 0.04
	material.metallic = 0.1
	ground.material_override = material
	add_child(ground)

	var probe = ReflectionProbe.new()
	probe.box_size = Vector3(30, 15, 30)
	probe.intensity = 1.0
	add_child(probe)

func _create_walls():
	var wall = MeshInstance3D.new()
	var cylinder = CylinderMesh.new()
	cylinder.top_radius = 15.0
	cylinder.bottom_radius = 15.0
	cylinder.height = 8.0
	cylinder.radial_segments = 64
	cylinder.cap_top = false
	cylinder.cap_bottom = false
	wall.mesh = cylinder
	var wall_material = StandardMaterial3D.new()
	wall_material.albedo_color = Color(0.95, 0.95, 0.95)
	wall_material.roughness = 0.1
	wall_material.metallic = 0.2
	wall.material_override = wall_material
	add_child(wall)

func _create_lighting():
	var light = DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-45, 30, 0)
	light.shadow_enabled = true
	light.light_energy = 2.0
	add_child(light)

func _create_camera():
	var camera = Camera3D.new()
	camera.position = Vector3(0, 2, 8)
	camera.look_at(Vector3(0, 1.5, 0))
	camera.current = true
	add_child(camera)

func _load_robot():
	var robot_resource = load("res://robot_k4000.glb")
	if robot_resource:
		var robot = robot_resource.instantiate()
		add_child(robot)
		robot.position = Vector3(0, 0, 0)
		robot.scale = Vector3(1.0, 1.0, 1.0)
		print("Robot loaded successfully")
	else:
		print("Failed to load robot from res://robot_k4000.glb")ر
