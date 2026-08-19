 extends Node3D

func _ready():
	print("Echo Lab - Main scene ready")
	_create_environment()
	_create_lab_floor()
	_create_lighting()
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
	# Reflection probe for realistic reflections
	var probe = ReflectionProbe.new()
	probe.box_size = Vector3(30, 15, 30)
	probe.intensity = 1.0
	add_child(probe)

func _create_lighting():
	var light = DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-45, 30, 0)
	light.shadow_enabled = true
	add_child(light)

func _load_robot():
	var robot_resource = load("res://robot_k4000.glb")
	if robot_resource:
		var robot = robot_resource.instantiate()
		add_child(robot)
		robot.position = Vector3(0, 0, 0)
		print("Robot loaded successfully")
	else:
		print("Failed to load robot from res://robot_k4000.glb")
