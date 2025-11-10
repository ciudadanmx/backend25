CREATE TABLE IF NOT EXISTS strapi_migrations (id SERIAL PRIMARY KEY, name varchar(255), time timestamp);

CREATE TABLE IF NOT EXISTS strapi_database_schema (id SERIAL PRIMARY KEY, schema json, time timestamp, hash varchar(255));

CREATE TABLE IF NOT EXISTS strapi_core_store_settings (id SERIAL PRIMARY KEY, key varchar(255) null, value text null, type varchar(255) null, environment varchar(255) null, tag varchar(255) null);

CREATE TABLE IF NOT EXISTS strapi_webhooks (id SERIAL PRIMARY KEY, name varchar(255) null, url text null, headers json null, events json null, enabled boolean null);

CREATE TABLE IF NOT EXISTS admin_permissions (id SERIAL PRIMARY KEY, action varchar(255) NULL, action_parameters json NULL, subject varchar(255) NULL, properties json NULL, conditions json NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS admin_users (id SERIAL PRIMARY KEY, firstname varchar(255) NULL, lastname varchar(255) NULL, username varchar(255) NULL, email varchar(255) NULL, password varchar(255) NULL, reset_password_token varchar(255) NULL, registration_token varchar(255) NULL, is_active boolean NULL, blocked boolean NULL, prefered_language varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS admin_roles (id SERIAL PRIMARY KEY, name varchar(255) NULL, code varchar(255) NULL, description varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS strapi_api_tokens (id SERIAL PRIMARY KEY, name varchar(255) NULL, description varchar(255) NULL, type varchar(255) NULL, access_key varchar(255) NULL, last_used_at timestamp NULL, expires_at timestamp NULL, lifespan bigint NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS strapi_api_token_permissions (id SERIAL PRIMARY KEY, action varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS strapi_transfer_tokens (id SERIAL PRIMARY KEY, name varchar(255) NULL, description varchar(255) NULL, access_key varchar(255) NULL, last_used_at timestamp NULL, expires_at timestamp NULL, lifespan bigint NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS strapi_transfer_token_permissions (id SERIAL PRIMARY KEY, action varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS files (id SERIAL PRIMARY KEY, name varchar(255) NULL, alternative_text varchar(255) NULL, caption varchar(255) NULL, width integer NULL, height integer NULL, formats json NULL, hash varchar(255) NULL, ext varchar(255) NULL, mime varchar(255) NULL, size float NULL, url varchar(255) NULL, preview_url varchar(255) NULL, provider varchar(255) NULL, provider_metadata json NULL, folder_path varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS upload_folders (id SERIAL PRIMARY KEY, name varchar(255) NULL, path_id integer NULL, path varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS strapi_releases (id SERIAL PRIMARY KEY, name varchar(255) NULL, released_at timestamp NULL, scheduled_at timestamp NULL, timezone varchar(255) NULL, status varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS strapi_release_actions (id SERIAL PRIMARY KEY, type varchar(255) NULL, target_id integer NULL, target_type varchar(255) NULL, content_type varchar(255) NULL, locale varchar(255) NULL, is_entry_valid boolean NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS i18n_locale (id SERIAL PRIMARY KEY, name varchar(255) NULL, code varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS up_permissions (id SERIAL PRIMARY KEY, action varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS up_roles (id SERIAL PRIMARY KEY, name varchar(255) NULL, description varchar(255) NULL, type varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS up_users (id SERIAL PRIMARY KEY, username varchar(255) NULL, email varchar(255) NULL, provider varchar(255) NULL, password varchar(255) NULL, reset_password_token varchar(255) NULL, confirmation_token varchar(255) NULL, confirmed boolean NULL, blocked boolean NULL, roles json NULL, prueba text NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, id_stripe varchar(255) null, fecha_registro timestamp null, membresia_vigente boolean null, tipo_membresia varchar(255) null, fecha_nacimiento timestamp null, fecha_membresia timestamp null, telefono varchar(255) null, cp varchar(255) null, nombre_completo varchar(255) null, fecha_fin_membresia_actual date null, stripe_customer_id varchar(255) null, stripe_subscription_id varchar(255) null, stripe_price_id varchar(255) null, subscription_status varchar(255) null);

CREATE TABLE IF NOT EXISTS as (id SERIAL PRIMARY KEY, a varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS carteras (id SERIAL PRIMARY KEY, laborys_ganados float NULL, laborys_saldo float NULL, ciudadan_tokens float NULL, ciudadan_rendimientos float NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS driver_locations (id SERIAL PRIMARY KEY, coords json NULL, time timestamp NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS gen_wallets (id SERIAL PRIMARY KEY, wallet_idx varchar(255) NULL, coin varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS messages (id SERIAL PRIMARY KEY, text text NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, timestamp timestamp null, status varchar(255) null);

CREATE TABLE IF NOT EXISTS world_coin_wallets (id SERIAL PRIMARY KEY, cartera_idx varchar(255) NULL, ammount float NULL, genesis boolean NULL, user_id varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS admin_permissions_role_links (id SERIAL PRIMARY KEY, permission_id integer NULL, role_id integer NULL, permission_order float NULL);

CREATE TABLE IF NOT EXISTS admin_users_roles_links (id SERIAL PRIMARY KEY, user_id integer NULL, role_id integer NULL, role_order float NULL, user_order float NULL);

CREATE TABLE IF NOT EXISTS strapi_api_token_permissions_token_links (id SERIAL PRIMARY KEY, api_token_permission_id integer NULL, api_token_id integer NULL, api_token_permission_order float NULL);

CREATE TABLE IF NOT EXISTS strapi_transfer_token_permissions_token_links (id SERIAL PRIMARY KEY, transfer_token_permission_id integer NULL, transfer_token_id integer NULL, transfer_token_permission_order float NULL);

CREATE TABLE IF NOT EXISTS files_related_morphs (id SERIAL PRIMARY KEY, file_id integer NULL, related_id integer NULL, related_type varchar(255) NULL, field varchar(255) NULL, order float NULL);

CREATE TABLE IF NOT EXISTS files_folder_links (id SERIAL PRIMARY KEY, file_id integer NULL, folder_id integer NULL, file_order float NULL);

CREATE TABLE IF NOT EXISTS upload_folders_parent_links (id SERIAL PRIMARY KEY, folder_id integer NULL, inv_folder_id integer NULL, folder_order float NULL);

CREATE TABLE IF NOT EXISTS strapi_release_actions_release_links (id SERIAL PRIMARY KEY, release_action_id integer NULL, release_id integer NULL, release_action_order float NULL);

CREATE TABLE IF NOT EXISTS up_permissions_role_links (id SERIAL PRIMARY KEY, permission_id integer NULL, role_id integer NULL, permission_order float NULL);

CREATE TABLE IF NOT EXISTS up_users_role_links (id SERIAL PRIMARY KEY, user_id integer NULL, role_id integer NULL, user_order float NULL);

CREATE TABLE IF NOT EXISTS carteras_user_id_links (id SERIAL PRIMARY KEY, cartera_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS driver_locations_driver_id_links (id SERIAL PRIMARY KEY, driver_location_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS messages_sender_id_links (id SERIAL PRIMARY KEY, message_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS messages_receiver_id_links (id SERIAL PRIMARY KEY, message_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS world_coin_wallets_user_idd_links (id SERIAL PRIMARY KEY, world_coin_wallet_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS clubs (id SERIAL PRIMARY KEY, nombre_club varchar(255) NULL, direccion json NULL, lat float NULL, lng float NULL, nombre_titular varchar(255) NULL, status_legal integer NULL, archivos_legal json NULL, descripcion text NULL, servicios json NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, locale varchar(255) NULL, auth_name varchar(255) null, horarios json null, whatsapp varchar(255) null, activo boolean null, tipo varchar(255) null);

CREATE TABLE IF NOT EXISTS clubs_localizations_links (id SERIAL PRIMARY KEY, club_id integer NULL, inv_club_id integer NULL, club_order float NULL);

CREATE TABLE IF NOT EXISTS clubs_users_permissions_user_links (id SERIAL PRIMARY KEY, club_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS stores_users_permissions_user_links (id SERIAL PRIMARY KEY, store_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS stores_localizations_links (id SERIAL PRIMARY KEY, store_id integer NULL, inv_store_id integer NULL, store_order float NULL);

CREATE TABLE IF NOT EXISTS store_categories (id SERIAL PRIMARY KEY, nombre varchar(255) NULL, descripcion text NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, slug varchar(255) null);

CREATE TABLE IF NOT EXISTS productos_store_category_links (id SERIAL PRIMARY KEY, producto_id integer NULL, store_categorie_id integer NULL);

CREATE TABLE IF NOT EXISTS productos_store_links (id SERIAL PRIMARY KEY, producto_id integer NULL, store_id integer NULL);

CREATE TABLE IF NOT EXISTS stores (id SERIAL PRIMARY KEY, name varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, locale varchar(255) NULL, email varchar(255) NULL, published_at timestamp null, stripe_account_id varchar(255) null, stripe_onboarded boolean null, stripe_charges_enabled boolean null, stripe_payouts_enabled boolean null, terminado boolean null, slug varchar(255) null, cp varchar(255) null, localidad varchar(255) null, esquema_impuestos varchar(255) null, paso integer null);

CREATE TABLE IF NOT EXISTS components_carritos_producto_en_carritos_producto_links (id SERIAL PRIMARY KEY, producto_en_carrito_id integer NULL, producto_id integer NULL);

CREATE TABLE IF NOT EXISTS carritos (id SERIAL PRIMARY KEY, total float NULL, estado varchar(255) NULL, ultima_actualizacion timestamp NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, log json null, total_envios float null, agrupacion_de_envios json null, usuario_email varchar(255) null);

CREATE TABLE IF NOT EXISTS carritos_components (id SERIAL PRIMARY KEY, entity_id integer NULL, component_id integer NULL, component_type varchar(255) NULL, field varchar(255) NULL, order float NULL);

CREATE TABLE IF NOT EXISTS carritos_usuario_links (id SERIAL PRIMARY KEY, carrito_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS resenas (id SERIAL PRIMARY KEY, comentario text NULL, timestamp timestamp NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, status varchar(255) null, observaciones text null, tipo varchar(255) null);

CREATE TABLE IF NOT EXISTS resenas_usuario_links (id SERIAL PRIMARY KEY, resena_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS resenas_producto_links (id SERIAL PRIMARY KEY, resena_id integer NULL, producto_id integer NULL);

CREATE TABLE IF NOT EXISTS resenas_carrito_links (id SERIAL PRIMARY KEY, resena_id integer NULL, carrito_id integer NULL);

CREATE TABLE IF NOT EXISTS notificaciones (id SERIAL PRIMARY KEY, cuerpo json NULL, user_email varchar(255) NULL, timestamp timestamp NULL, leida boolean NULL, status varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, tipo varchar(255) null);

CREATE TABLE IF NOT EXISTS categorias_cursos (id SERIAL PRIMARY KEY, nombre varchar(255) NULL, nivel integer NULL, sup integer NULL, descripcion text NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, slug varchar(255) null, activa boolean null);

CREATE TABLE IF NOT EXISTS publicaciones (id SERIAL PRIMARY KEY, contenido json NULL, timestamp timestamp NULL, publicado varchar(255) NULL, uid varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS publicaciones_autor_links (id SERIAL PRIMARY KEY, publicacion_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS direcciones_store_id_links (id SERIAL PRIMARY KEY, direccion_id integer NULL, store_id integer NULL);

CREATE TABLE IF NOT EXISTS direcciones_event_id_links (id SERIAL PRIMARY KEY, direccion_id integer NULL, evento_id integer NULL);

CREATE TABLE IF NOT EXISTS up_users_direcciones_links (id SERIAL PRIMARY KEY, user_id integer NULL, direccion_id integer NULL, direccion_order float NULL);

CREATE TABLE IF NOT EXISTS comentarios_publicaciones (id SERIAL PRIMARY KEY, comentario text NULL, timestamp timestamp NULL, status varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, respuesta boolean null, tipo varchar(255) null);

CREATE TABLE IF NOT EXISTS comentarios_publicaciones_autor_links (id SERIAL PRIMARY KEY, comentario_publicacion_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS resenas_curso_id_links (id SERIAL PRIMARY KEY, resena_id integer NULL, curso_id integer NULL);

CREATE TABLE IF NOT EXISTS resenas_club_id_links (id SERIAL PRIMARY KEY, resena_id integer NULL, club_id integer NULL);

CREATE TABLE IF NOT EXISTS carritos_direccion_links (id SERIAL PRIMARY KEY, carrito_id integer NULL, direccion_id integer NULL);

CREATE TABLE IF NOT EXISTS comentarios_publicaciones_publicacion_id_links (id SERIAL PRIMARY KEY, comentario_publicacion_id integer NULL, publicacion_id integer NULL);

CREATE TABLE IF NOT EXISTS cursos_maestro_links (id SERIAL PRIMARY KEY, curso_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS cursos_ubicacion_links (id SERIAL PRIMARY KEY, curso_id integer NULL, direccion_id integer NULL);

CREATE TABLE IF NOT EXISTS eventos_creador_links (id SERIAL PRIMARY KEY, evento_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS eventos_direccion_links (id SERIAL PRIMARY KEY, evento_id integer NULL, direccion_id integer NULL);

CREATE TABLE IF NOT EXISTS notificaciones_usuario_links (id SERIAL PRIMARY KEY, notificacion_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS comentarios_publicaciones_comentario_id_links (id SERIAL PRIMARY KEY, comentario_publicacion_id integer NULL, inv_comentario_publicacion_id integer NULL);

CREATE TABLE IF NOT EXISTS resenas_evento_id_links (id SERIAL PRIMARY KEY, resena_id integer NULL, evento_id integer NULL);

CREATE TABLE IF NOT EXISTS configuraciones_usuarios (id SERIAL PRIMARY KEY, email varchar(255) NULL, configuraciones json NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS configuraciones_usuarios_usuario_links (id SERIAL PRIMARY KEY, configuracion_usuario_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS enlaces_autor_links (id SERIAL PRIMARY KEY, enlace_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS listas_suscripciones (id SERIAL PRIMARY KEY, tipo varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS listas_suscripciones_suscritos_links (id SERIAL PRIMARY KEY, lista_suscripcion_id integer NULL, user_id integer NULL, user_order float NULL);

CREATE TABLE IF NOT EXISTS listas_suscripciones_curso_links (id SERIAL PRIMARY KEY, lista_suscripcion_id integer NULL, curso_id integer NULL);

CREATE TABLE IF NOT EXISTS listas_suscripciones_evento_links (id SERIAL PRIMARY KEY, lista_suscripcion_id integer NULL, evento_id integer NULL);

CREATE TABLE IF NOT EXISTS reacciones (id SERIAL PRIMARY KEY, listado json NULL, tipo varchar(255) NULL, comentario boolean NULL, respuesta boolean NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS reacciones_evento_id_links (id SERIAL PRIMARY KEY, reaccion_id integer NULL, evento_id integer NULL);

CREATE TABLE IF NOT EXISTS reacciones_enlace_id_links (id SERIAL PRIMARY KEY, reaccion_id integer NULL, enlace_id integer NULL);

CREATE TABLE IF NOT EXISTS reacciones_comentario_id_links (id SERIAL PRIMARY KEY, reaccion_id integer NULL, comentario_publicacion_id integer NULL);

CREATE TABLE IF NOT EXISTS categorias_enlaces (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, descripcion text NULL, nivel integer NULL, sup integer NULL, activa boolean NULL, slug varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS categorias_eventos (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, descripcion text NULL, nivel integer NULL, sup integer NULL, slug varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, activa boolean null);

CREATE TABLE IF NOT EXISTS categorias_herramientas (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, descripcion text NULL, slug varchar(255) NULL, nivel integer NULL, sup integer NULL, activa boolean NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS configuraciones_sistemas (id SERIAL PRIMARY KEY, basic_set json NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, datos_generales json null);

CREATE TABLE IF NOT EXISTS pedidos_components (id SERIAL PRIMARY KEY, entity_id integer NULL, component_id integer NULL, component_type varchar(255) NULL, field varchar(255) NULL, order float NULL);

CREATE TABLE IF NOT EXISTS pedidos_curso_id_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, curso_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos_evento_id_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, evento_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos_usuario_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos_direccion_origen_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, direccion_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos_direccion_destino_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, direccion_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos_carrito_id_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, carrito_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos (id SERIAL PRIMARY KEY, tipo varchar(255) NULL, timestamp_creacion timestamp NULL, guia varchar(255) NULL, proveedor varchar(255) NULL, fecha_envio timestamp NULL, fecha_entrega timestamp NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, total_volumetrico float NULL, monto_envio float NULL, monto_total float NULL, fecha_pagado timestamp NULL, moneda varchar(255) NULL, status varchar(255) null);

CREATE TABLE IF NOT EXISTS components_carritos_producto_en_carritos (id SERIAL PRIMARY KEY, nombre varchar(255) NULL, precio_unitario float NULL, cantidad integer NULL, subtotal float NULL, envio float NULL, subtotal_volumetrico float NULL, esquema_impuestos varchar(255) NULL, cp varchar(255) null, total float null, comision_stripe float null, comision_plataforma float null);

CREATE TABLE IF NOT EXISTS pagos (id SERIAL PRIMARY KEY, idx varchar(255) NULL, tipo varchar(255) NULL, fecha_pagado timestamp NULL, monto float NULL, moneda varchar(255) NULL, stripe_payment_intent_id varchar(255) NULL, stripe_invoice_id varchar(255) NULL, stripe_customer_id varchar(255) NULL, stripe_subscription_id varchar(255) NULL, status varchar(255) NULL, descripcion varchar(255) NULL, metadata json NULL, disputa boolean NULL, metodo_pago varchar(255) NULL, observaciones text NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, pago_guia float null, pago_vendedor float null, comision_stripe float null, comision_plataforma float null);

CREATE TABLE IF NOT EXISTS pagos_carrito_id_links (id SERIAL PRIMARY KEY, pago_id integer NULL, carrito_id integer NULL);

CREATE TABLE IF NOT EXISTS pagos_curso_id_links (id SERIAL PRIMARY KEY, pago_id integer NULL, curso_id integer NULL);

CREATE TABLE IF NOT EXISTS pagos_evento_id_links (id SERIAL PRIMARY KEY, pago_id integer NULL, evento_id integer NULL);

CREATE TABLE IF NOT EXISTS pagos_usuario_links (id SERIAL PRIMARY KEY, pago_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS servicios (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, descripcion text NULL, precio_fijo boolean NULL, precio float NULL, slug varchar(255) NULL, descripcion_precio text NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS servicios_prestador_links (id SERIAL PRIMARY KEY, servicio_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS enlaces_enlace_id_links (id SERIAL PRIMARY KEY, enlace_id integer NULL, inv_enlace_id integer NULL);

CREATE TABLE IF NOT EXISTS enlaces (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, timestamp timestamp NULL, descripcion text NULL, calificacion integer NULL, calificaciones integer NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, status varchar(255) NULL, url varchar(255) NULL);

CREATE TABLE IF NOT EXISTS eventos_evento_id_links (id SERIAL PRIMARY KEY, evento_id integer NULL, inv_evento_id integer NULL);

CREATE TABLE IF NOT EXISTS pedidos_pago_id_links (id SERIAL PRIMARY KEY, pedido_id integer NULL, pago_id integer NULL);

CREATE TABLE IF NOT EXISTS stores_direccion_links (id SERIAL PRIMARY KEY, store_id integer NULL, direccion_id integer NULL);

CREATE TABLE IF NOT EXISTS contenidos (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, slug varchar(255) NULL, contenido_libre json NULL, contenido_restringido json NULL, restringido boolean NULL, status varchar(255) NULL, tags text NULL, fecha_publicacion timestamp NULL, resumen varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, autor_email varchar(255) null, autor_nombre varchar(255) null);

CREATE TABLE IF NOT EXISTS contenidos_autor_links (id SERIAL PRIMARY KEY, contenido_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS direcciones_club_links (id SERIAL PRIMARY KEY, direccion_id integer NULL, club_id integer NULL);

CREATE TABLE IF NOT EXISTS productos (id SERIAL PRIMARY KEY, nombre varchar(255) NULL, descripcion varchar(255) NULL, precio float NULL, marca varchar(255) NULL, activo boolean NULL, destacado boolean NULL, store_id varchar(255) NULL, store_email varchar(255) NULL, stripe_product_id varchar(255) NULL, tags text NULL, fecha_creacion timestamp NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, stock float NULL, calificacion integer NULL, calificaciones integer NULL, vendidos integer NULL, cp varchar(255) NULL, slug varchar(255) NULL, largo float NULL, ancho float NULL, alto float NULL, peso float NULL, volumetrico float NULL, especificaciones json NULL, variaciones json NULL, localidad varchar(255) NULL, estado varchar(255) null);

CREATE TABLE IF NOT EXISTS components_carritos_producto_en_carritos_store_links (id SERIAL PRIMARY KEY, producto_en_carrito_id integer NULL, store_id integer NULL);

CREATE TABLE IF NOT EXISTS membresias (id SERIAL PRIMARY KEY, fecha_inicio date NULL, fecha_fin date NULL, plan varchar(255) NULL, monto_pagado float NULL, activa boolean NULL, miembro_desde timestamp NULL, observaciones varchar(255) NULL, status varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS membresias_usuario_links (id SERIAL PRIMARY KEY, membresia_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS categorias_contenidos (id SERIAL PRIMARY KEY, nombre varchar(255) NULL, activa boolean NULL, slug varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, descripcion varchar(255) null);

CREATE TABLE IF NOT EXISTS contenidos_categoria_links (id SERIAL PRIMARY KEY, contenido_id integer NULL, categoria_contenido_id integer NULL);

CREATE TABLE IF NOT EXISTS pagos_store_links (id SERIAL PRIMARY KEY, pago_id integer NULL, store_id integer NULL);

CREATE TABLE IF NOT EXISTS preguntas_productos (id SERIAL PRIMARY KEY, pregunta text NULL, respuesta text NULL, fechapregunta timestamp NULL, fecharespuesta timestamp NULL, status varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL);

CREATE TABLE IF NOT EXISTS preguntas_productos_producto_links (id SERIAL PRIMARY KEY, pregunta_producto_id integer NULL, producto_id integer NULL, pregunta_producto_order float NULL);

CREATE TABLE IF NOT EXISTS preguntas_productos_usuario_links (id SERIAL PRIMARY KEY, pregunta_producto_id integer NULL, user_id integer NULL);

CREATE TABLE IF NOT EXISTS preguntas_productos_store_links (id SERIAL PRIMARY KEY, pregunta_producto_id integer NULL, store_id integer NULL, pregunta_producto_order float NULL);

CREATE TABLE IF NOT EXISTS direcciones (id SERIAL PRIMARY KEY, direccion json NULL, coords json NULL, cp varchar(255) NULL, ciudad varchar(255) NULL, estado varchar(255) NULL, observaciones varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, activa boolean NULL, user_email varchar(255) NULL);

CREATE TABLE IF NOT EXISTS cursos (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, modalidad varchar(255) NULL, certificacion varchar(255) NULL, precio float NULL, descripcion text NULL, calendario_actividades json NULL, calificacion integer NULL, calificaciones integer NULL, temario json NULL, fecha_inicio timestamp NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, slug varchar(255) NULL, de_pago boolean NULL, enlace_reunion varchar(255) NULL, enlaces_publicos json NULL, enlaces_privados json NULL, status varchar(255) NULL, maestro_email varchar(255) NULL, maestro_nombre varchar(255) NULL, resumen varchar(255) NULL, tags varchar(255) NULL, restringido boolean NULL, fecha_publicacion timestamp NULL);

CREATE TABLE IF NOT EXISTS cursos_categoria_links (id SERIAL PRIMARY KEY, curso_id integer NULL, categoria_curso_id integer NULL);

CREATE TABLE IF NOT EXISTS eventos (id SERIAL PRIMARY KEY, titulo varchar(255) NULL, slug varchar(255) NULL, descripcion text NULL, colaboradores json NULL, de_pago boolean NULL, precio float NULL, ciudad varchar(255) NULL, estado varchar(255) NULL, multifecha boolean NULL, fecha_inicio date NULL, hora_inicio time NULL, fechas_horarios_adicionales json NULL, fecha_fin date NULL, hora_fin time NULL, modalidad varchar(255) NULL, status varchar(255) NULL, created_at timestamp NULL, updated_at timestamp NULL, published_at timestamp NULL, created_by_id integer NULL, updated_by_id integer NULL, url varchar(255) NULL);

ALTER TABLE admin_permissions ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE admin_permissions ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE admin_users ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE admin_users ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE admin_roles ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE admin_roles ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE strapi_api_tokens ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE strapi_api_tokens ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE strapi_api_token_permissions ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE strapi_api_token_permissions ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE strapi_transfer_tokens ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE strapi_transfer_tokens ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE strapi_transfer_token_permissions ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE strapi_transfer_token_permissions ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE files ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE files ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE upload_folders ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE upload_folders ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE strapi_releases ADD CONSTRAINT strapi_releases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE strapi_releases ADD CONSTRAINT strapi_releases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE strapi_release_actions ADD CONSTRAINT strapi_release_actions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE strapi_release_actions ADD CONSTRAINT strapi_release_actions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE i18n_locale ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE i18n_locale ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE up_permissions ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE up_permissions ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE up_roles ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE up_roles ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE up_users ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE up_users ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE as ADD CONSTRAINT as_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE as ADD CONSTRAINT as_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE carteras ADD CONSTRAINT carteras_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE carteras ADD CONSTRAINT carteras_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE driver_locations ADD CONSTRAINT driver_locations_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE driver_locations ADD CONSTRAINT driver_locations_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE gen_wallets ADD CONSTRAINT gen_wallets_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE gen_wallets ADD CONSTRAINT gen_wallets_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE messages ADD CONSTRAINT messages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE messages ADD CONSTRAINT messages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE world_coin_wallets ADD CONSTRAINT world_coin_wallets_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE world_coin_wallets ADD CONSTRAINT world_coin_wallets_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE admin_permissions_role_links ADD CONSTRAINT admin_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES admin_permissions (id) ON DELETE CASCADE;

ALTER TABLE admin_permissions_role_links ADD CONSTRAINT admin_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES admin_roles (id) ON DELETE CASCADE;

ALTER TABLE admin_permissions_role_links ADD CONSTRAINT admin_permissions_role_links_permission_id_fk FOREIGN KEY (permission_id) REFERENCES admin_permissions (id) ON DELETE CASCADE;

ALTER TABLE admin_permissions_role_links ADD CONSTRAINT admin_permissions_role_links_role_id_fk FOREIGN KEY (role_id) REFERENCES admin_roles (id) ON DELETE CASCADE;

ALTER TABLE admin_users_roles_links ADD CONSTRAINT admin_users_roles_links_fk FOREIGN KEY (user_id) REFERENCES admin_users (id) ON DELETE CASCADE;

ALTER TABLE admin_users_roles_links ADD CONSTRAINT admin_users_roles_links_inv_fk FOREIGN KEY (role_id) REFERENCES admin_roles (id) ON DELETE CASCADE;

ALTER TABLE admin_users_roles_links ADD CONSTRAINT admin_users_roles_links_user_id_fk FOREIGN KEY (user_id) REFERENCES admin_users (id) ON DELETE CASCADE;

ALTER TABLE admin_users_roles_links ADD CONSTRAINT admin_users_roles_links_role_id_fk FOREIGN KEY (role_id) REFERENCES admin_roles (id) ON DELETE CASCADE;

ALTER TABLE strapi_api_token_permissions_token_links ADD CONSTRAINT strapi_api_token_permissions_token_links_fk FOREIGN KEY (api_token_permission_id) REFERENCES strapi_api_token_permissions (id) ON DELETE CASCADE;

ALTER TABLE strapi_api_token_permissions_token_links ADD CONSTRAINT strapi_api_token_permissions_token_links_inv_fk FOREIGN KEY (api_token_id) REFERENCES strapi_api_tokens (id) ON DELETE CASCADE;

ALTER TABLE strapi_api_token_permissions_token_links ADD CONSTRAINT strapi_api_token_permissions_token_links_api_token_permission_id_fk FOREIGN KEY (api_token_permission_id) REFERENCES strapi_api_token_permissions (id) ON DELETE CASCADE;

ALTER TABLE strapi_api_token_permissions_token_links ADD CONSTRAINT strapi_api_token_permissions_token_links_api_token_id_fk FOREIGN KEY (api_token_id) REFERENCES strapi_api_tokens (id) ON DELETE CASCADE;

ALTER TABLE strapi_transfer_token_permissions_token_links ADD CONSTRAINT strapi_transfer_token_permissions_token_links_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES strapi_transfer_token_permissions (id) ON DELETE CASCADE;

ALTER TABLE strapi_transfer_token_permissions_token_links ADD CONSTRAINT strapi_transfer_token_permissions_token_links_inv_fk FOREIGN KEY (transfer_token_id) REFERENCES strapi_transfer_tokens (id) ON DELETE CASCADE;

ALTER TABLE strapi_transfer_token_permissions_token_links ADD CONSTRAINT strapi_transfer_token_permissions_token_links_transfer_token_permission_id_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES strapi_transfer_token_permissions (id) ON DELETE CASCADE;

ALTER TABLE strapi_transfer_token_permissions_token_links ADD CONSTRAINT strapi_transfer_token_permissions_token_links_transfer_token_id_fk FOREIGN KEY (transfer_token_id) REFERENCES strapi_transfer_tokens (id) ON DELETE CASCADE;

ALTER TABLE files_related_morphs ADD CONSTRAINT files_related_morphs_fk FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE CASCADE;

ALTER TABLE files_related_morphs ADD CONSTRAINT files_related_morphs_file_id_fk FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE CASCADE;

ALTER TABLE files_folder_links ADD CONSTRAINT files_folder_links_fk FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE CASCADE;

ALTER TABLE files_folder_links ADD CONSTRAINT files_folder_links_inv_fk FOREIGN KEY (folder_id) REFERENCES upload_folders (id) ON DELETE CASCADE;

ALTER TABLE files_folder_links ADD CONSTRAINT files_folder_links_file_id_fk FOREIGN KEY (file_id) REFERENCES files (id) ON DELETE CASCADE;

ALTER TABLE files_folder_links ADD CONSTRAINT files_folder_links_folder_id_fk FOREIGN KEY (folder_id) REFERENCES upload_folders (id) ON DELETE CASCADE;

ALTER TABLE upload_folders_parent_links ADD CONSTRAINT upload_folders_parent_links_fk FOREIGN KEY (folder_id) REFERENCES upload_folders (id) ON DELETE CASCADE;

ALTER TABLE upload_folders_parent_links ADD CONSTRAINT upload_folders_parent_links_inv_fk FOREIGN KEY (inv_folder_id) REFERENCES upload_folders (id) ON DELETE CASCADE;

ALTER TABLE upload_folders_parent_links ADD CONSTRAINT upload_folders_parent_links_folder_id_fk FOREIGN KEY (folder_id) REFERENCES upload_folders (id) ON DELETE CASCADE;

ALTER TABLE upload_folders_parent_links ADD CONSTRAINT upload_folders_parent_links_inv_folder_id_fk FOREIGN KEY (inv_folder_id) REFERENCES upload_folders (id) ON DELETE CASCADE;

ALTER TABLE strapi_release_actions_release_links ADD CONSTRAINT strapi_release_actions_release_links_fk FOREIGN KEY (release_action_id) REFERENCES strapi_release_actions (id) ON DELETE CASCADE;

ALTER TABLE strapi_release_actions_release_links ADD CONSTRAINT strapi_release_actions_release_links_inv_fk FOREIGN KEY (release_id) REFERENCES strapi_releases (id) ON DELETE CASCADE;

ALTER TABLE strapi_release_actions_release_links ADD CONSTRAINT strapi_release_actions_release_links_release_action_id_fk FOREIGN KEY (release_action_id) REFERENCES strapi_release_actions (id) ON DELETE CASCADE;

ALTER TABLE strapi_release_actions_release_links ADD CONSTRAINT strapi_release_actions_release_links_release_id_fk FOREIGN KEY (release_id) REFERENCES strapi_releases (id) ON DELETE CASCADE;

ALTER TABLE up_permissions_role_links ADD CONSTRAINT up_permissions_role_links_fk FOREIGN KEY (permission_id) REFERENCES up_permissions (id) ON DELETE CASCADE;

ALTER TABLE up_permissions_role_links ADD CONSTRAINT up_permissions_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES up_roles (id) ON DELETE CASCADE;

ALTER TABLE up_permissions_role_links ADD CONSTRAINT up_permissions_role_links_permission_id_fk FOREIGN KEY (permission_id) REFERENCES up_permissions (id) ON DELETE CASCADE;

ALTER TABLE up_permissions_role_links ADD CONSTRAINT up_permissions_role_links_role_id_fk FOREIGN KEY (role_id) REFERENCES up_roles (id) ON DELETE CASCADE;

ALTER TABLE up_users_role_links ADD CONSTRAINT up_users_role_links_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE up_users_role_links ADD CONSTRAINT up_users_role_links_inv_fk FOREIGN KEY (role_id) REFERENCES up_roles (id) ON DELETE CASCADE;

ALTER TABLE up_users_role_links ADD CONSTRAINT up_users_role_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE up_users_role_links ADD CONSTRAINT up_users_role_links_role_id_fk FOREIGN KEY (role_id) REFERENCES up_roles (id) ON DELETE CASCADE;

ALTER TABLE carteras_user_id_links ADD CONSTRAINT carteras_user_id_links_fk FOREIGN KEY (cartera_id) REFERENCES carteras (id) ON DELETE CASCADE;

ALTER TABLE carteras_user_id_links ADD CONSTRAINT carteras_user_id_links_inv_fk FOREIGN KEY (user_id) REFERENCES admin_users (id) ON DELETE CASCADE;

ALTER TABLE carteras_user_id_links ADD CONSTRAINT carteras_user_id_links_cartera_id_fk FOREIGN KEY (cartera_id) REFERENCES carteras (id) ON DELETE CASCADE;

ALTER TABLE carteras_user_id_links ADD CONSTRAINT carteras_user_id_links_user_id_fk FOREIGN KEY (user_id) REFERENCES admin_users (id) ON DELETE CASCADE;

ALTER TABLE driver_locations_driver_id_links ADD CONSTRAINT driver_locations_driver_id_links_fk FOREIGN KEY (driver_location_id) REFERENCES driver_locations (id) ON DELETE CASCADE;

ALTER TABLE driver_locations_driver_id_links ADD CONSTRAINT driver_locations_driver_id_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE driver_locations_driver_id_links ADD CONSTRAINT driver_locations_driver_id_links_driver_location_id_fk FOREIGN KEY (driver_location_id) REFERENCES driver_locations (id) ON DELETE CASCADE;

ALTER TABLE driver_locations_driver_id_links ADD CONSTRAINT driver_locations_driver_id_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE messages_sender_id_links ADD CONSTRAINT messages_sender_id_links_fk FOREIGN KEY (message_id) REFERENCES messages (id) ON DELETE CASCADE;

ALTER TABLE messages_sender_id_links ADD CONSTRAINT messages_sender_id_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE messages_sender_id_links ADD CONSTRAINT messages_sender_id_links_message_id_fk FOREIGN KEY (message_id) REFERENCES messages (id) ON DELETE CASCADE;

ALTER TABLE messages_sender_id_links ADD CONSTRAINT messages_sender_id_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE messages_receiver_id_links ADD CONSTRAINT messages_receiver_id_links_fk FOREIGN KEY (message_id) REFERENCES messages (id) ON DELETE CASCADE;

ALTER TABLE messages_receiver_id_links ADD CONSTRAINT messages_receiver_id_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE messages_receiver_id_links ADD CONSTRAINT messages_receiver_id_links_message_id_fk FOREIGN KEY (message_id) REFERENCES messages (id) ON DELETE CASCADE;

ALTER TABLE messages_receiver_id_links ADD CONSTRAINT messages_receiver_id_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE world_coin_wallets_user_idd_links ADD CONSTRAINT world_coin_wallets_user_idd_links_fk FOREIGN KEY (world_coin_wallet_id) REFERENCES world_coin_wallets (id) ON DELETE CASCADE;

ALTER TABLE world_coin_wallets_user_idd_links ADD CONSTRAINT world_coin_wallets_user_idd_links_inv_fk FOREIGN KEY (user_id) REFERENCES admin_users (id) ON DELETE CASCADE;

ALTER TABLE world_coin_wallets_user_idd_links ADD CONSTRAINT world_coin_wallets_user_idd_links_world_coin_wallet_id_fk FOREIGN KEY (world_coin_wallet_id) REFERENCES world_coin_wallets (id) ON DELETE CASCADE;

ALTER TABLE world_coin_wallets_user_idd_links ADD CONSTRAINT world_coin_wallets_user_idd_links_user_id_fk FOREIGN KEY (user_id) REFERENCES admin_users (id) ON DELETE CASCADE;

ALTER TABLE clubs ADD CONSTRAINT clubs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE clubs ADD CONSTRAINT clubs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE clubs_localizations_links ADD CONSTRAINT clubs_localizations_links_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE clubs_localizations_links ADD CONSTRAINT clubs_localizations_links_inv_fk FOREIGN KEY (inv_club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE clubs_localizations_links ADD CONSTRAINT clubs_localizations_links_club_id_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE clubs_localizations_links ADD CONSTRAINT clubs_localizations_links_inv_club_id_fk FOREIGN KEY (inv_club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE clubs_users_permissions_user_links ADD CONSTRAINT clubs_users_permissions_user_links_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE clubs_users_permissions_user_links ADD CONSTRAINT clubs_users_permissions_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE clubs_users_permissions_user_links ADD CONSTRAINT clubs_users_permissions_user_links_club_id_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE clubs_users_permissions_user_links ADD CONSTRAINT clubs_users_permissions_user_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE stores_users_permissions_user_links ADD CONSTRAINT stores_users_permissions_user_links_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_users_permissions_user_links ADD CONSTRAINT stores_users_permissions_user_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE stores_users_permissions_user_links ADD CONSTRAINT stores_users_permissions_user_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_users_permissions_user_links ADD CONSTRAINT stores_users_permissions_user_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE stores_localizations_links ADD CONSTRAINT stores_localizations_links_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_localizations_links ADD CONSTRAINT stores_localizations_links_inv_fk FOREIGN KEY (inv_store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_localizations_links ADD CONSTRAINT stores_localizations_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_localizations_links ADD CONSTRAINT stores_localizations_links_inv_store_id_fk FOREIGN KEY (inv_store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE store_categories ADD CONSTRAINT store_categories_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE store_categories ADD CONSTRAINT store_categories_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE productos_store_category_links ADD CONSTRAINT productos_store_category_links_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE productos_store_category_links ADD CONSTRAINT productos_store_category_links_inv_fk FOREIGN KEY (store_categorie_id) REFERENCES store_categories (id) ON DELETE CASCADE;

ALTER TABLE productos_store_category_links ADD CONSTRAINT productos_store_category_links_producto_id_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE productos_store_category_links ADD CONSTRAINT productos_store_category_links_store_categorie_id_fk FOREIGN KEY (store_categorie_id) REFERENCES store_categories (id) ON DELETE CASCADE;

ALTER TABLE productos_store_links ADD CONSTRAINT productos_store_links_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE productos_store_links ADD CONSTRAINT productos_store_links_inv_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE productos_store_links ADD CONSTRAINT productos_store_links_producto_id_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE productos_store_links ADD CONSTRAINT productos_store_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores ADD CONSTRAINT stores_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE stores ADD CONSTRAINT stores_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE components_carritos_producto_en_carritos_producto_links ADD CONSTRAINT components_carritos_producto_en_carritos_producto_links_fk FOREIGN KEY (producto_en_carrito_id) REFERENCES components_carritos_producto_en_carritos (id) ON DELETE CASCADE;

ALTER TABLE components_carritos_producto_en_carritos_producto_links ADD CONSTRAINT components_carritos_producto_en_carritos_producto_links_inv_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE components_carritos_producto_en_carritos_producto_links ADD CONSTRAINT components_carritos_producto_en_carritos_producto_links_producto_en_carrito_id_fk FOREIGN KEY (producto_en_carrito_id) REFERENCES components_carritos_producto_en_carritos (id) ON DELETE CASCADE;

ALTER TABLE components_carritos_producto_en_carritos_producto_links ADD CONSTRAINT components_carritos_producto_en_carritos_producto_links_producto_id_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE carritos ADD CONSTRAINT carritos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE carritos ADD CONSTRAINT carritos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE carritos_components ADD CONSTRAINT carritos_entity_fk FOREIGN KEY (entity_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE carritos_components ADD CONSTRAINT carritos_components_entity_id_fk FOREIGN KEY (entity_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE carritos_usuario_links ADD CONSTRAINT carritos_usuario_links_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE carritos_usuario_links ADD CONSTRAINT carritos_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE carritos_usuario_links ADD CONSTRAINT carritos_usuario_links_carrito_id_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE carritos_usuario_links ADD CONSTRAINT carritos_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE resenas ADD CONSTRAINT resenas_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE resenas ADD CONSTRAINT resenas_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE resenas_usuario_links ADD CONSTRAINT resenas_usuario_links_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_usuario_links ADD CONSTRAINT resenas_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE resenas_usuario_links ADD CONSTRAINT resenas_usuario_links_resena_id_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_usuario_links ADD CONSTRAINT resenas_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE resenas_producto_links ADD CONSTRAINT resenas_producto_links_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_producto_links ADD CONSTRAINT resenas_producto_links_inv_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE resenas_producto_links ADD CONSTRAINT resenas_producto_links_resena_id_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_producto_links ADD CONSTRAINT resenas_producto_links_producto_id_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE resenas_carrito_links ADD CONSTRAINT resenas_carrito_links_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_carrito_links ADD CONSTRAINT resenas_carrito_links_inv_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE resenas_carrito_links ADD CONSTRAINT resenas_carrito_links_resena_id_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_carrito_links ADD CONSTRAINT resenas_carrito_links_carrito_id_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE notificaciones ADD CONSTRAINT notificaciones_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE notificaciones ADD CONSTRAINT notificaciones_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE categorias_cursos ADD CONSTRAINT categorias_cursos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE categorias_cursos ADD CONSTRAINT categorias_cursos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE publicaciones ADD CONSTRAINT publicaciones_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE publicaciones ADD CONSTRAINT publicaciones_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE publicaciones_autor_links ADD CONSTRAINT publicaciones_autor_links_fk FOREIGN KEY (publicacion_id) REFERENCES publicaciones (id) ON DELETE CASCADE;

ALTER TABLE publicaciones_autor_links ADD CONSTRAINT publicaciones_autor_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE publicaciones_autor_links ADD CONSTRAINT publicaciones_autor_links_publicacion_id_fk FOREIGN KEY (publicacion_id) REFERENCES publicaciones (id) ON DELETE CASCADE;

ALTER TABLE publicaciones_autor_links ADD CONSTRAINT publicaciones_autor_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE direcciones_store_id_links ADD CONSTRAINT direcciones_store_id_links_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE direcciones_store_id_links ADD CONSTRAINT direcciones_store_id_links_inv_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE direcciones_store_id_links ADD CONSTRAINT direcciones_store_id_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE direcciones_store_id_links ADD CONSTRAINT direcciones_store_id_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE direcciones_event_id_links ADD CONSTRAINT direcciones_event_id_links_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE direcciones_event_id_links ADD CONSTRAINT direcciones_event_id_links_inv_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE direcciones_event_id_links ADD CONSTRAINT direcciones_event_id_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE direcciones_event_id_links ADD CONSTRAINT direcciones_event_id_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE up_users_direcciones_links ADD CONSTRAINT up_users_direcciones_links_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE up_users_direcciones_links ADD CONSTRAINT up_users_direcciones_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE up_users_direcciones_links ADD CONSTRAINT up_users_direcciones_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE up_users_direcciones_links ADD CONSTRAINT up_users_direcciones_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones ADD CONSTRAINT comentarios_publicaciones_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE comentarios_publicaciones ADD CONSTRAINT comentarios_publicaciones_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE comentarios_publicaciones_autor_links ADD CONSTRAINT comentarios_publicaciones_autor_links_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_autor_links ADD CONSTRAINT comentarios_publicaciones_autor_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_autor_links ADD CONSTRAINT comentarios_publicaciones_autor_links_comentario_publicacion_id_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_autor_links ADD CONSTRAINT comentarios_publicaciones_autor_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE resenas_curso_id_links ADD CONSTRAINT resenas_curso_id_links_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_curso_id_links ADD CONSTRAINT resenas_curso_id_links_inv_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE resenas_curso_id_links ADD CONSTRAINT resenas_curso_id_links_resena_id_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_curso_id_links ADD CONSTRAINT resenas_curso_id_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE resenas_club_id_links ADD CONSTRAINT resenas_club_id_links_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_club_id_links ADD CONSTRAINT resenas_club_id_links_inv_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE resenas_club_id_links ADD CONSTRAINT resenas_club_id_links_resena_id_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_club_id_links ADD CONSTRAINT resenas_club_id_links_club_id_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE carritos_direccion_links ADD CONSTRAINT carritos_direccion_links_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE carritos_direccion_links ADD CONSTRAINT carritos_direccion_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE carritos_direccion_links ADD CONSTRAINT carritos_direccion_links_carrito_id_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE carritos_direccion_links ADD CONSTRAINT carritos_direccion_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_publicacion_id_links ADD CONSTRAINT comentarios_publicaciones_publicacion_id_links_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_publicacion_id_links ADD CONSTRAINT comentarios_publicaciones_publicacion_id_links_inv_fk FOREIGN KEY (publicacion_id) REFERENCES publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_publicacion_id_links ADD CONSTRAINT comentarios_publicaciones_publicacion_id_links_comentario_publicacion_id_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_publicacion_id_links ADD CONSTRAINT comentarios_publicaciones_publicacion_id_links_publicacion_id_fk FOREIGN KEY (publicacion_id) REFERENCES publicaciones (id) ON DELETE CASCADE;

ALTER TABLE cursos_maestro_links ADD CONSTRAINT cursos_maestro_links_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_maestro_links ADD CONSTRAINT cursos_maestro_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE cursos_maestro_links ADD CONSTRAINT cursos_maestro_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_maestro_links ADD CONSTRAINT cursos_maestro_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE cursos_ubicacion_links ADD CONSTRAINT cursos_ubicacion_links_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_ubicacion_links ADD CONSTRAINT cursos_ubicacion_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE cursos_ubicacion_links ADD CONSTRAINT cursos_ubicacion_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_ubicacion_links ADD CONSTRAINT cursos_ubicacion_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE eventos_creador_links ADD CONSTRAINT eventos_creador_links_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_creador_links ADD CONSTRAINT eventos_creador_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE eventos_creador_links ADD CONSTRAINT eventos_creador_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_creador_links ADD CONSTRAINT eventos_creador_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE eventos_direccion_links ADD CONSTRAINT eventos_direccion_links_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_direccion_links ADD CONSTRAINT eventos_direccion_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE eventos_direccion_links ADD CONSTRAINT eventos_direccion_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_direccion_links ADD CONSTRAINT eventos_direccion_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE notificaciones_usuario_links ADD CONSTRAINT notificaciones_usuario_links_fk FOREIGN KEY (notificacion_id) REFERENCES notificaciones (id) ON DELETE CASCADE;

ALTER TABLE notificaciones_usuario_links ADD CONSTRAINT notificaciones_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE notificaciones_usuario_links ADD CONSTRAINT notificaciones_usuario_links_notificacion_id_fk FOREIGN KEY (notificacion_id) REFERENCES notificaciones (id) ON DELETE CASCADE;

ALTER TABLE notificaciones_usuario_links ADD CONSTRAINT notificaciones_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_comentario_id_links ADD CONSTRAINT comentarios_publicaciones_comentario_id_links_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_comentario_id_links ADD CONSTRAINT comentarios_publicaciones_comentario_id_links_inv_fk FOREIGN KEY (inv_comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_comentario_id_links ADD CONSTRAINT comentarios_publicaciones_comentario_id_links_comentario_publicacion_id_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE comentarios_publicaciones_comentario_id_links ADD CONSTRAINT comentarios_publicaciones_comentario_id_links_inv_comentario_publicacion_id_fk FOREIGN KEY (inv_comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE resenas_evento_id_links ADD CONSTRAINT resenas_evento_id_links_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_evento_id_links ADD CONSTRAINT resenas_evento_id_links_inv_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE resenas_evento_id_links ADD CONSTRAINT resenas_evento_id_links_resena_id_fk FOREIGN KEY (resena_id) REFERENCES resenas (id) ON DELETE CASCADE;

ALTER TABLE resenas_evento_id_links ADD CONSTRAINT resenas_evento_id_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE configuraciones_usuarios ADD CONSTRAINT configuraciones_usuarios_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE configuraciones_usuarios ADD CONSTRAINT configuraciones_usuarios_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE configuraciones_usuarios_usuario_links ADD CONSTRAINT configuraciones_usuarios_usuario_links_fk FOREIGN KEY (configuracion_usuario_id) REFERENCES configuraciones_usuarios (id) ON DELETE CASCADE;

ALTER TABLE configuraciones_usuarios_usuario_links ADD CONSTRAINT configuraciones_usuarios_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE configuraciones_usuarios_usuario_links ADD CONSTRAINT configuraciones_usuarios_usuario_links_configuracion_usuario_id_fk FOREIGN KEY (configuracion_usuario_id) REFERENCES configuraciones_usuarios (id) ON DELETE CASCADE;

ALTER TABLE configuraciones_usuarios_usuario_links ADD CONSTRAINT configuraciones_usuarios_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE enlaces_autor_links ADD CONSTRAINT enlaces_autor_links_fk FOREIGN KEY (enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE enlaces_autor_links ADD CONSTRAINT enlaces_autor_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE enlaces_autor_links ADD CONSTRAINT enlaces_autor_links_enlace_id_fk FOREIGN KEY (enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE enlaces_autor_links ADD CONSTRAINT enlaces_autor_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones ADD CONSTRAINT listas_suscripciones_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE listas_suscripciones ADD CONSTRAINT listas_suscripciones_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE listas_suscripciones_suscritos_links ADD CONSTRAINT listas_suscripciones_suscritos_links_fk FOREIGN KEY (lista_suscripcion_id) REFERENCES listas_suscripciones (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_suscritos_links ADD CONSTRAINT listas_suscripciones_suscritos_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_suscritos_links ADD CONSTRAINT listas_suscripciones_suscritos_links_lista_suscripcion_id_fk FOREIGN KEY (lista_suscripcion_id) REFERENCES listas_suscripciones (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_suscritos_links ADD CONSTRAINT listas_suscripciones_suscritos_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_curso_links ADD CONSTRAINT listas_suscripciones_curso_links_fk FOREIGN KEY (lista_suscripcion_id) REFERENCES listas_suscripciones (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_curso_links ADD CONSTRAINT listas_suscripciones_curso_links_inv_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_curso_links ADD CONSTRAINT listas_suscripciones_curso_links_lista_suscripcion_id_fk FOREIGN KEY (lista_suscripcion_id) REFERENCES listas_suscripciones (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_curso_links ADD CONSTRAINT listas_suscripciones_curso_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_evento_links ADD CONSTRAINT listas_suscripciones_evento_links_fk FOREIGN KEY (lista_suscripcion_id) REFERENCES listas_suscripciones (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_evento_links ADD CONSTRAINT listas_suscripciones_evento_links_inv_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_evento_links ADD CONSTRAINT listas_suscripciones_evento_links_lista_suscripcion_id_fk FOREIGN KEY (lista_suscripcion_id) REFERENCES listas_suscripciones (id) ON DELETE CASCADE;

ALTER TABLE listas_suscripciones_evento_links ADD CONSTRAINT listas_suscripciones_evento_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE reacciones ADD CONSTRAINT reacciones_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE reacciones ADD CONSTRAINT reacciones_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE reacciones_evento_id_links ADD CONSTRAINT reacciones_evento_id_links_fk FOREIGN KEY (reaccion_id) REFERENCES reacciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_evento_id_links ADD CONSTRAINT reacciones_evento_id_links_inv_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE reacciones_evento_id_links ADD CONSTRAINT reacciones_evento_id_links_reaccion_id_fk FOREIGN KEY (reaccion_id) REFERENCES reacciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_evento_id_links ADD CONSTRAINT reacciones_evento_id_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE reacciones_enlace_id_links ADD CONSTRAINT reacciones_enlace_id_links_fk FOREIGN KEY (reaccion_id) REFERENCES reacciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_enlace_id_links ADD CONSTRAINT reacciones_enlace_id_links_inv_fk FOREIGN KEY (enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE reacciones_enlace_id_links ADD CONSTRAINT reacciones_enlace_id_links_reaccion_id_fk FOREIGN KEY (reaccion_id) REFERENCES reacciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_enlace_id_links ADD CONSTRAINT reacciones_enlace_id_links_enlace_id_fk FOREIGN KEY (enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE reacciones_comentario_id_links ADD CONSTRAINT reacciones_comentario_id_links_fk FOREIGN KEY (reaccion_id) REFERENCES reacciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_comentario_id_links ADD CONSTRAINT reacciones_comentario_id_links_inv_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_comentario_id_links ADD CONSTRAINT reacciones_comentario_id_links_reaccion_id_fk FOREIGN KEY (reaccion_id) REFERENCES reacciones (id) ON DELETE CASCADE;

ALTER TABLE reacciones_comentario_id_links ADD CONSTRAINT reacciones_comentario_id_links_comentario_publicacion_id_fk FOREIGN KEY (comentario_publicacion_id) REFERENCES comentarios_publicaciones (id) ON DELETE CASCADE;

ALTER TABLE categorias_enlaces ADD CONSTRAINT categorias_enlaces_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE categorias_enlaces ADD CONSTRAINT categorias_enlaces_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE categorias_eventos ADD CONSTRAINT categorias_eventos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE categorias_eventos ADD CONSTRAINT categorias_eventos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE categorias_herramientas ADD CONSTRAINT categorias_herramientas_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE categorias_herramientas ADD CONSTRAINT categorias_herramientas_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE configuraciones_sistemas ADD CONSTRAINT configuraciones_sistemas_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE configuraciones_sistemas ADD CONSTRAINT configuraciones_sistemas_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE pedidos_components ADD CONSTRAINT pedidos_entity_fk FOREIGN KEY (entity_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_components ADD CONSTRAINT pedidos_components_entity_id_fk FOREIGN KEY (entity_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_curso_id_links ADD CONSTRAINT pedidos_curso_id_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_curso_id_links ADD CONSTRAINT pedidos_curso_id_links_inv_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_curso_id_links ADD CONSTRAINT pedidos_curso_id_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_curso_id_links ADD CONSTRAINT pedidos_curso_id_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_evento_id_links ADD CONSTRAINT pedidos_evento_id_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_evento_id_links ADD CONSTRAINT pedidos_evento_id_links_inv_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_evento_id_links ADD CONSTRAINT pedidos_evento_id_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_evento_id_links ADD CONSTRAINT pedidos_evento_id_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_usuario_links ADD CONSTRAINT pedidos_usuario_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_usuario_links ADD CONSTRAINT pedidos_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE pedidos_usuario_links ADD CONSTRAINT pedidos_usuario_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_usuario_links ADD CONSTRAINT pedidos_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_origen_links ADD CONSTRAINT pedidos_direccion_origen_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_origen_links ADD CONSTRAINT pedidos_direccion_origen_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_origen_links ADD CONSTRAINT pedidos_direccion_origen_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_origen_links ADD CONSTRAINT pedidos_direccion_origen_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_destino_links ADD CONSTRAINT pedidos_direccion_destino_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_destino_links ADD CONSTRAINT pedidos_direccion_destino_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_destino_links ADD CONSTRAINT pedidos_direccion_destino_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_direccion_destino_links ADD CONSTRAINT pedidos_direccion_destino_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE pedidos_carrito_id_links ADD CONSTRAINT pedidos_carrito_id_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_carrito_id_links ADD CONSTRAINT pedidos_carrito_id_links_inv_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_carrito_id_links ADD CONSTRAINT pedidos_carrito_id_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_carrito_id_links ADD CONSTRAINT pedidos_carrito_id_links_carrito_id_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE pedidos ADD CONSTRAINT pedidos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE pedidos ADD CONSTRAINT pedidos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE pagos ADD CONSTRAINT pagos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE pagos ADD CONSTRAINT pagos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE pagos_carrito_id_links ADD CONSTRAINT pagos_carrito_id_links_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_carrito_id_links ADD CONSTRAINT pagos_carrito_id_links_inv_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE pagos_carrito_id_links ADD CONSTRAINT pagos_carrito_id_links_pago_id_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_carrito_id_links ADD CONSTRAINT pagos_carrito_id_links_carrito_id_fk FOREIGN KEY (carrito_id) REFERENCES carritos (id) ON DELETE CASCADE;

ALTER TABLE pagos_curso_id_links ADD CONSTRAINT pagos_curso_id_links_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_curso_id_links ADD CONSTRAINT pagos_curso_id_links_inv_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE pagos_curso_id_links ADD CONSTRAINT pagos_curso_id_links_pago_id_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_curso_id_links ADD CONSTRAINT pagos_curso_id_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE pagos_evento_id_links ADD CONSTRAINT pagos_evento_id_links_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_evento_id_links ADD CONSTRAINT pagos_evento_id_links_inv_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE pagos_evento_id_links ADD CONSTRAINT pagos_evento_id_links_pago_id_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_evento_id_links ADD CONSTRAINT pagos_evento_id_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE pagos_usuario_links ADD CONSTRAINT pagos_usuario_links_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_usuario_links ADD CONSTRAINT pagos_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE pagos_usuario_links ADD CONSTRAINT pagos_usuario_links_pago_id_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_usuario_links ADD CONSTRAINT pagos_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE servicios ADD CONSTRAINT servicios_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE servicios ADD CONSTRAINT servicios_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE servicios_prestador_links ADD CONSTRAINT servicios_prestador_links_fk FOREIGN KEY (servicio_id) REFERENCES servicios (id) ON DELETE CASCADE;

ALTER TABLE servicios_prestador_links ADD CONSTRAINT servicios_prestador_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE servicios_prestador_links ADD CONSTRAINT servicios_prestador_links_servicio_id_fk FOREIGN KEY (servicio_id) REFERENCES servicios (id) ON DELETE CASCADE;

ALTER TABLE servicios_prestador_links ADD CONSTRAINT servicios_prestador_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE enlaces_enlace_id_links ADD CONSTRAINT enlaces_enlace_id_links_fk FOREIGN KEY (enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE enlaces_enlace_id_links ADD CONSTRAINT enlaces_enlace_id_links_inv_fk FOREIGN KEY (inv_enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE enlaces_enlace_id_links ADD CONSTRAINT enlaces_enlace_id_links_enlace_id_fk FOREIGN KEY (enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE enlaces_enlace_id_links ADD CONSTRAINT enlaces_enlace_id_links_inv_enlace_id_fk FOREIGN KEY (inv_enlace_id) REFERENCES enlaces (id) ON DELETE CASCADE;

ALTER TABLE enlaces ADD CONSTRAINT enlaces_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE enlaces ADD CONSTRAINT enlaces_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE eventos_evento_id_links ADD CONSTRAINT eventos_evento_id_links_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_evento_id_links ADD CONSTRAINT eventos_evento_id_links_inv_fk FOREIGN KEY (inv_evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_evento_id_links ADD CONSTRAINT eventos_evento_id_links_evento_id_fk FOREIGN KEY (evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE eventos_evento_id_links ADD CONSTRAINT eventos_evento_id_links_inv_evento_id_fk FOREIGN KEY (inv_evento_id) REFERENCES eventos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_pago_id_links ADD CONSTRAINT pedidos_pago_id_links_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_pago_id_links ADD CONSTRAINT pedidos_pago_id_links_inv_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_pago_id_links ADD CONSTRAINT pedidos_pago_id_links_pedido_id_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON DELETE CASCADE;

ALTER TABLE pedidos_pago_id_links ADD CONSTRAINT pedidos_pago_id_links_pago_id_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE stores_direccion_links ADD CONSTRAINT stores_direccion_links_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_direccion_links ADD CONSTRAINT stores_direccion_links_inv_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE stores_direccion_links ADD CONSTRAINT stores_direccion_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE stores_direccion_links ADD CONSTRAINT stores_direccion_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE contenidos ADD CONSTRAINT contenidos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE contenidos ADD CONSTRAINT contenidos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE contenidos_autor_links ADD CONSTRAINT contenidos_autor_links_fk FOREIGN KEY (contenido_id) REFERENCES contenidos (id) ON DELETE CASCADE;

ALTER TABLE contenidos_autor_links ADD CONSTRAINT contenidos_autor_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE contenidos_autor_links ADD CONSTRAINT contenidos_autor_links_contenido_id_fk FOREIGN KEY (contenido_id) REFERENCES contenidos (id) ON DELETE CASCADE;

ALTER TABLE contenidos_autor_links ADD CONSTRAINT contenidos_autor_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE direcciones_club_links ADD CONSTRAINT direcciones_club_links_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE direcciones_club_links ADD CONSTRAINT direcciones_club_links_inv_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE direcciones_club_links ADD CONSTRAINT direcciones_club_links_direccion_id_fk FOREIGN KEY (direccion_id) REFERENCES direcciones (id) ON DELETE CASCADE;

ALTER TABLE direcciones_club_links ADD CONSTRAINT direcciones_club_links_club_id_fk FOREIGN KEY (club_id) REFERENCES clubs (id) ON DELETE CASCADE;

ALTER TABLE productos ADD CONSTRAINT productos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE productos ADD CONSTRAINT productos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE components_carritos_producto_en_carritos_store_links ADD CONSTRAINT components_carritos_producto_en_carritos_store_links_fk FOREIGN KEY (producto_en_carrito_id) REFERENCES components_carritos_producto_en_carritos (id) ON DELETE CASCADE;

ALTER TABLE components_carritos_producto_en_carritos_store_links ADD CONSTRAINT components_carritos_producto_en_carritos_store_links_inv_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE components_carritos_producto_en_carritos_store_links ADD CONSTRAINT components_carritos_producto_en_carritos_store_links_producto_en_carrito_id_fk FOREIGN KEY (producto_en_carrito_id) REFERENCES components_carritos_producto_en_carritos (id) ON DELETE CASCADE;

ALTER TABLE components_carritos_producto_en_carritos_store_links ADD CONSTRAINT components_carritos_producto_en_carritos_store_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE membresias ADD CONSTRAINT membresias_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE membresias ADD CONSTRAINT membresias_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE membresias_usuario_links ADD CONSTRAINT membresias_usuario_links_fk FOREIGN KEY (membresia_id) REFERENCES membresias (id) ON DELETE CASCADE;

ALTER TABLE membresias_usuario_links ADD CONSTRAINT membresias_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE membresias_usuario_links ADD CONSTRAINT membresias_usuario_links_membresia_id_fk FOREIGN KEY (membresia_id) REFERENCES membresias (id) ON DELETE CASCADE;

ALTER TABLE membresias_usuario_links ADD CONSTRAINT membresias_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE categorias_contenidos ADD CONSTRAINT categorias_contenidos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE categorias_contenidos ADD CONSTRAINT categorias_contenidos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE contenidos_categoria_links ADD CONSTRAINT contenidos_categoria_links_fk FOREIGN KEY (contenido_id) REFERENCES contenidos (id) ON DELETE CASCADE;

ALTER TABLE contenidos_categoria_links ADD CONSTRAINT contenidos_categoria_links_inv_fk FOREIGN KEY (categoria_contenido_id) REFERENCES categorias_contenidos (id) ON DELETE CASCADE;

ALTER TABLE contenidos_categoria_links ADD CONSTRAINT contenidos_categoria_links_contenido_id_fk FOREIGN KEY (contenido_id) REFERENCES contenidos (id) ON DELETE CASCADE;

ALTER TABLE contenidos_categoria_links ADD CONSTRAINT contenidos_categoria_links_categoria_contenido_id_fk FOREIGN KEY (categoria_contenido_id) REFERENCES categorias_contenidos (id) ON DELETE CASCADE;

ALTER TABLE pagos_store_links ADD CONSTRAINT pagos_store_links_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_store_links ADD CONSTRAINT pagos_store_links_inv_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE pagos_store_links ADD CONSTRAINT pagos_store_links_pago_id_fk FOREIGN KEY (pago_id) REFERENCES pagos (id) ON DELETE CASCADE;

ALTER TABLE pagos_store_links ADD CONSTRAINT pagos_store_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos ADD CONSTRAINT preguntas_productos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE preguntas_productos ADD CONSTRAINT preguntas_productos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE preguntas_productos_producto_links ADD CONSTRAINT preguntas_productos_producto_links_fk FOREIGN KEY (pregunta_producto_id) REFERENCES preguntas_productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_producto_links ADD CONSTRAINT preguntas_productos_producto_links_inv_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_producto_links ADD CONSTRAINT preguntas_productos_producto_links_pregunta_producto_id_fk FOREIGN KEY (pregunta_producto_id) REFERENCES preguntas_productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_producto_links ADD CONSTRAINT preguntas_productos_producto_links_producto_id_fk FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_usuario_links ADD CONSTRAINT preguntas_productos_usuario_links_fk FOREIGN KEY (pregunta_producto_id) REFERENCES preguntas_productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_usuario_links ADD CONSTRAINT preguntas_productos_usuario_links_inv_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_usuario_links ADD CONSTRAINT preguntas_productos_usuario_links_pregunta_producto_id_fk FOREIGN KEY (pregunta_producto_id) REFERENCES preguntas_productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_usuario_links ADD CONSTRAINT preguntas_productos_usuario_links_user_id_fk FOREIGN KEY (user_id) REFERENCES up_users (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_store_links ADD CONSTRAINT preguntas_productos_store_links_fk FOREIGN KEY (pregunta_producto_id) REFERENCES preguntas_productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_store_links ADD CONSTRAINT preguntas_productos_store_links_inv_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_store_links ADD CONSTRAINT preguntas_productos_store_links_pregunta_producto_id_fk FOREIGN KEY (pregunta_producto_id) REFERENCES preguntas_productos (id) ON DELETE CASCADE;

ALTER TABLE preguntas_productos_store_links ADD CONSTRAINT preguntas_productos_store_links_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE direcciones ADD CONSTRAINT direcciones_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE direcciones ADD CONSTRAINT direcciones_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE cursos ADD CONSTRAINT cursos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE cursos ADD CONSTRAINT cursos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;



ALTER TABLE cursos_categoria_links ADD CONSTRAINT cursos_categoria_links_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_categoria_links ADD CONSTRAINT cursos_categoria_links_inv_fk FOREIGN KEY (categoria_curso_id) REFERENCES categorias_cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_categoria_links ADD CONSTRAINT cursos_categoria_links_curso_id_fk FOREIGN KEY (curso_id) REFERENCES cursos (id) ON DELETE CASCADE;

ALTER TABLE cursos_categoria_links ADD CONSTRAINT cursos_categoria_links_categoria_curso_id_fk FOREIGN KEY (categoria_curso_id) REFERENCES categorias_cursos (id) ON DELETE CASCADE;

ALTER TABLE eventos ADD CONSTRAINT eventos_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;

ALTER TABLE eventos ADD CONSTRAINT eventos_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES admin_users (id) ON DELETE SET NULL;


