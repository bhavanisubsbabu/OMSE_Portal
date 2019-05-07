 ALTER TABLE t_user DROP CONSTRAINT if exists fk_user_login_map;
 alter table t_usergroup drop constraint if exists fk_usergroup_created_by; 

delete from t_endpoint_whitelist;
delete from t_event_audit;
delete from t_application_url ;
delete from t_usergroup_user;
delete from t_layer_asset_group;
delete from t_map_thumbnail;
delete from t_resource;
delete from t_resource_type;
delete from t_endpoint_authentication;
DELETE FROM t_layer_fc;
delete from t_role_permission;
delete from t_map_layer;
delete from t_map_tag;
DELETE FROM t_feature_property;
DELETE FROM t_usergroup_user;
DELETE FROM t_role_permission;
delete from t_permission;
delete from t_layer;
delete from t_endpoint;
delete from t_asset_group;
delete from t_map;
delete from t_basemap;
DELETE FROM t_user;
delete from t_usergroup;
DELETE FROM t_base_layer_product;
DELETE FROM t_feature_collection;
DELETE FROM t_feature;
DELETE FROM t_role;

DELETE FROM t_tag;
DELETE FROM t_permission;
alter table t_user add constraint fk_user_login_map foreign key (login_map_id) references t_map(id);
alter table t_usergroup add constraint fk_usergroup_created_by foreign key (created_by_id) references t_user(id);





INSERT INTO t_role (id, name, display_name, default_landing_url) VALUES (nextval('hibernate_sequence'), 'role.administrator', 'Administrator', '/map');
INSERT INTO t_role (id, name, display_name, default_landing_url) VALUES (nextval('hibernate_sequence'), 'role.support', 'Support', '/admin/user');
INSERT INTO t_role (id, name, display_name, default_landing_url) VALUES (nextval('hibernate_sequence'), 'role.author', 'Author', '/map');
INSERT INTO t_role (id, name, display_name, default_landing_url) VALUES (nextval('hibernate_sequence'), 'role.viewer', 'Viewer', '/map');

INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.application.access');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.organisation.create');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.organisation.list');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.user.create');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.user.create.approve');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.user.disable');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.organisation.disable');

INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.map.gallery.view');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.map.view');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.map.create');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.layer.import');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.layer.add.to.library');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.layer.create');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.map.edit');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.map.share');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.map.print');

INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.data.library.view');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.data.library.import');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.layer.share');
INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.data.loader');


INSERT INTO t_role_permission (role_id, permission_id)
  SELECT
    t_role.id,
    t_permission.id
  FROM t_role, t_permission
  WHERE t_role.name = 'role.administrator'
        AND t_permission.name IN
            (
                'permission.application.access',
                'permission.user.create',
                'permission.user.create.approve',
                'permission.user.disable',
                'permission.map.gallery.view',
                'permission.map.view',
                'permission.map.create',
                'permission.layer.import',
                'permission.layer.add.to.library',
                'permission.layer.create',
                'permission.map.edit',
                'permission.map.share',
                'permission.map.print',
                'permission.data.library.view',
                'permission.data.library.import',
                'permission.layer.share'
                          );

INSERT INTO t_role_permission (role_id, permission_id)
  SELECT
    t_role.id,
    t_permission.id
  FROM t_role, t_permission
  WHERE t_role.name = 'role.support'
        AND t_permission.name IN
            (
                'permission.application.access',
                'permission.organisation.create',
                'permission.user.create',
                'permission.user.create.approve',
                'permission.user.disable',
                'permission.organisation.disable',
                'permission.organisation.list',
                'permission.data.loader'
            );


INSERT INTO t_role_permission (role_id, permission_id)
  SELECT
    t_role.id,
    t_permission.id
  FROM t_role, t_permission
  WHERE t_role.name = 'role.author'
        AND t_permission.name IN
        (
            'permission.application.access',
            'permission.map.gallery.view',
            'permission.map.view',
            'permission.map.create',
            'permission.layer.import',
            'permission.layer.add.to.library',
            'permission.layer.create',
            'permission.map.edit',
            'permission.map.share',
            'permission.map.print'
        );

INSERT INTO t_role_permission (role_id, permission_id)
  SELECT
    t_role.id,
    t_permission.id
  FROM t_role, t_permission
  WHERE t_role.name = 'role.viewer'
        AND t_permission.name IN
        (
            'permission.application.access',
            'permission.map.gallery.view',
            'permission.map.view',
            'permission.map.print'
        );


INSERT INTO t_usergroup (id, name, enabled, default_usergroup) VALUES (nextval('hibernate_sequence'), 'Resilience Direct', true, true);

INSERT INTO t_user (id, username, password, password_temporary, email, display_name, first_name, last_name, date_Created, usergroup_id, validated, enabled, role_id, password_expiry_date)
  SELECT
    nextval('hibernate_sequence'),
    'mmadmin',
    '7a4646ec08a4fa44403ecc79795331ec1ee078391b7f862e6731ab05745854f66f19e0adaa1ee4c2',
    true,
    'admin@mapmaker.com',
    'Admin User',
    'Admin',
    'User',
    current_timestamp,
    t_usergroup.id,
    TRUE,
    TRUE,
    t_role.id,
    now() + interval '1 day'
  FROM t_usergroup, T_ROLE
  WHERE t_usergroup.name = 'Resilience Direct'
  AND T_ROLE.name='role.support';



------------------------------------------------------------------------------------------------------------------------------
-- Map Stuff
------------------------------------------------------------------------------------------------------------------------------


INSERT INTO t_base_layer_product (name, enabled) VALUES ('OS_PRO_CS', true);

INSERT INTO t_tag (id, name) VALUES (nextval('hibernate_sequence'), 'os_pro_cs');

--#insert into t_layer_type(name) values ('WMS');



INSERT INTO t_layer (id, name, description, published_state, layer_type, owner_id, base_layer_product_name, projection, editable_when_displayed, usergroup_id, deleted, visible, is_default, valid_as_base_layer)
  SELECT
    nextval('hibernate_sequence'),
    'OS_PRO_CS',
    'OS CS PRO Base Layer',
    'S',
    'BASE',
    u.id,
    p.name,
    'EPSG:27700',
    TRUE   ,
    u.usergroup_id,
    false, 
    true, true, true
  FROM t_user u, t_base_layer_product p
  WHERE p.name = 'OS_PRO_CS'
        AND u.username = 'mmadmin';


 update t_map t_map set usergroup_id = (select usergroup_id from t_user where id = t_map.owner_id);
 
  update t_layer set published_state ='S' where id in (select layer_id from t_map_layer ml, t_map m
            where m.id = ml.map_id
            and m.published_state = 'S');
            
            update t_map_layer set deleted = false;
             
              
               update t_user set PASSWORD_EXPIRY_DATE = now() + interval '1 year';
               
INSERT INTO t_basemap (id, name, description, owner_id, current_version)
            SELECT
            nextval('hibernate_sequence'),
            'mmadmin base map',
            'Base map for mmadmin',
            t_user.id,
            1
            FROM t_user
            WHERE t_user.username = 'mmadmin';

            INSERT INTO t_map (id, name, description, date_created, base_map_id, owner_id, published_state, zoom,
            centre_lat, centre_lon, preview_image, map_version, current_version, version, usergroup_id)
            SELECT
            nextval('hibernate_sequence'),
            'Default Map',
            'Default Map for mmadmin',
            current_timestamp,
            t_basemap.id,
            t_user.id,
            'S',
            3,
            440000,
            90000,
            'basemap.jpg',
            1,
            TRUE,
            0 ,
            t_usergroup.id
            FROM t_user, t_basemap , t_usergroup
            WHERE t_user.username = 'mmadmin'
            AND t_basemap.name = 'mmadmin base map'
            and t_usergroup.name = 'Resilience Direct';

            INSERT INTO t_map_layer (map_id, layer_id, deleted, base_layer)
            SELECT
            m.id,
            l.id,
            FALSE, true
            FROM t_map m, t_layer l
            WHERE l.name = 'OS_PRO_CS'
            AND m.description = 'Default Map for mmadmin';

            INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.user.list');

INSERT INTO t_role_permission (role_id, permission_id)
  SELECT
    t_role.id,
    t_permission.id
  FROM t_role, t_permission
  WHERE t_role.name = 'role.administrator'
        AND t_permission.name IN
            ('permission.user.list');

INSERT INTO t_role_permission (role_id, permission_id)
  SELECT
    t_role.id,
    t_permission.id
  FROM t_role, t_permission
  WHERE t_role.name = 'role.support'
        AND t_permission.name IN
            ( 'permission.user.list');

            
            
            update t_user set login_map_id = (select id from t_map where description = 'Default Map for mmadmin') where
            username='mmadmin';

insert into t_application_url (id, app_code, url) values (nextval('hibernate_sequence'),
            'app.url.landing.support.user', '/admin/users' );

            insert into t_application_url (id, app_code, url) values (nextval('hibernate_sequence'),
            'app.url.landing.default', '/map' );

            insert into t_application_url (id, app_code, url) values (nextval('hibernate_sequence'),
            'app.url.password.reset', '/auth/reset' );

            insert into t_application_url (id, app_code, url) values (nextval('hibernate_sequence'), 'app.url.login',
            '/login' );

            insert into t_application_url (id, app_code, url) values (nextval('hibernate_sequence'), 'app.url.logout',
            '/login?logout' );

            insert into t_application_url (id, app_code, url) values (nextval('hibernate_sequence'),
            'app.url.tmp.password.expired', '/login?expired' );             
             

insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, true, false, true
            from t_role r, t_role r2
            where r.name='role.support' and r2.name = 'role.support';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, true, true, true
            from t_role r, t_role r2
            where r.name='role.support' and r2.name = 'role.administrator';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, true, true, true
            from t_role r, t_role r2
            where r.name='role.support' and r2.name = 'role.author';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, true, true, true
            from t_role r, t_role r2
            where r.name='role.support' and r2.name = 'role.viewer';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, false, false, false
            from t_role r, t_role r2
            where r.name='role.administrator' and r2.name = 'role.support';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, false, false, false
            from t_role r, t_role r2
            where r.name='role.administrator' and r2.name = 'role.administrator';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, true, true, true
            from t_role r, t_role r2
            where r.name='role.administrator' and r2.name = 'role.author';

            insert into t_roleauthority(id, role_id, role_authority_id, insert, update, delete)
            select nextval('hibernate_sequence'), r.id, r2.id, true, true, true
            from t_role r, t_role r2
            where r.name='role.administrator' and r2.name = 'role.viewer';
            
            update t_layer set title = name;
            
            insert into t_asset_group (id, name, usergroup_id, published_state, contains)
            select nextval('hibernate_sequence'), name, id, 'S', 'LAYER'
            from t_usergroup;
       
            insert into t_layer_asset_group (layer_id, asset_group_id)
            select layer.id, asset_group.id
            from t_layer layer, t_asset_group asset_group, t_usergroup org
            where asset_group.name = org.name
            and layer.usergroup_id = org.id;
            update t_layer l set asset_group_id = (select asset_group_id from t_layer_asset_group lag where
            lag.layer_id = l.id);
            
            update t_layer set title = name where title is null;
            -- RES-875_update_layer_title
            
            
            update t_base_layer_product set enabled = true;
            
            insert into t_base_layer_product (name, enabled)
            values ('OS_PRO_CS_TOPO', true);
     
            INSERT INTO t_layer (id, name, description, published_state, endpoint, layer_type, owner_id, base_layer_product_name, projection, editable_when_displayed, usergroup_id, alias, link_to_layer_name, deleted, visible, is_default, valid_as_base_layer)
            SELECT
            nextval('hibernate_sequence'),
            'OS_PRO_CS_TOPO',
            'OS CS PRO with Topo Base Layer',
            'S',
            'http://osondemand.ordnancesurvey.co.uk/ondemand/wms/MAP.do',
            'BASE',
            u.id,
            p.name,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            'topo',
            'OS_PRO_CS',
            false, true, false, true
            FROM t_user u, t_base_layer_product p
            WHERE p.name = 'OS_PRO_CS_TOPO'
            AND u.username = 'mmadmin';
    
            update t_base_layer_product set enabled = false where name = 'OS_PRO_CS';
   
            update t_layer
            set alias = 'ospro',
                endpoint = 'https://osopenspacepro.ordnancesurvey.co.uk/osmapapi/ts'
            where base_layer_product_name='OS_PRO_CS';
    
        update t_base_layer_product set enabled = true where name = 'OS_PRO_CS';
        update t_base_layer_product set enabled = false where name = 'OS_PRO_CS_TOPO';


            insert into t_endpoint_authentication
            (id, endpoint_id, user_id, uses_basic_http_auth, api_key, api_key_name, published_state, referer, request_url,request_url_name)
            select nextval('hibernate_sequence'), tlayer.id, tuser.id, false, 'placeholder_apikey', 'KEY', 'S', 'placeholder_referer', 'placeholder_url', 'URL'
            from t_layer tlayer, t_user tuser
            where tlayer.base_layer_product_name = 'OS_PRO_CS'
            and tuser.username='mmadmin' ;

            insert into t_endpoint_authentication
            (id, endpoint_id, user_id, uses_basic_http_auth, uid, password, published_state)
            select nextval('hibernate_sequence'), tlayer.id, tuser.id, true, 'placeholder_uid', 'placeholder_password', 'S'
            from t_layer tlayer, t_user tuser
            where tlayer.base_layer_product_name = 'OS_PRO_CS_TOPO'
            and tuser.username='mmadmin';
      
            update t_endpoint_authentication
            set api_key='KEQAHAQA',
            referer='http://localhost:8080/oslabs/mapmaker',
            request_url = 'https%3A%2F%2Fdemos.ordnancesurvey.co.uk%2Fpublic%2Fdemos%2Fopenspace%2Fhtml5%2Fgeolocate1.html'
            where endpoint_id in (select id from t_layer where layer_type='BASE' and base_layer_product_name='OS_PRO_CS')
            and published_state = 'S';
       
            update t_layer set endpoint = 'https://osopenspacepro.ordnancesurvey.co.uk/osmapapi/ts' where layer_type='BASE' and base_layer_product_name='OS_PRO_CS';
        
            update t_endpoint_authentication
            set uid='0040099848',
            password='62PJUX3B'
            where layer_id in (select id from t_layer where layer_type='BASE' and base_layer_product_name='OS_PRO_CS_TOPO')
            and published_state = 'S';
        
            update t_layer set endpoint = 'http://osondemand.ordnancesurvey.co.uk/ondemand/wms/MAP.do' where layer_type='BASE' and base_layer_product_name='OS_PRO_CS_TOPO';
       
            update t_layer set deleted = false;
            
         -- updated change log until (changeSet id="RES-1152_add_map_layer_index" author="dsoutham">)
         
            update t_layer set name = 'OpenSpace Pro' where base_layer_product_name = 'OS_PRO_CS'
            update t_layer set name = 'OpenSpace Pro with MasterMap' where base_layer_product_name = 'OS_PRO_CS_TOPO'
      
            insert into t_base_layer_product (name, enabled)
            values ('OS_LEISURE', true);
        
            INSERT INTO t_layer (id, name, description, published_state, endpoint, layer_type, owner_id, base_layer_product_name, projection, editable_when_displayed, usergroup_id, alias, link_to_layer_name, enabled, deleted)
            SELECT
            nextval('hibernate_sequence'),
            'OS Leisure',
            'OS Leisure stack',
            'S',
            'https://osopenspacepro.ordnancesurvey.co.uk/osmapapi/ts',
            'BASE',
            u.id,
            p.name,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null,
            true,
            false
            FROM t_user u, t_base_layer_product p
            WHERE p.name = 'OS_LEISURE'
            AND u.username = 'mmadmin';
  

            insert into t_endpoint_authentication
            (id, layer_id, user_id, uses_basic_http_auth, api_key, api_key_name, published_state, referer)
            select nextval('hibernate_sequence'), tlayer.id, tuser.id, false, 'placeholder_apikey', 'KEY', 'S', 'placeholder_referer'
            from t_layer tlayer, t_user tuser
            where tlayer.base_layer_product_name = 'OS_LEISURE'
            and tuser.username='mmadmin' ;
 

            update t_endpoint_authentication
            set api_key='${os.pro.cs.key}',
            referer='${os.pro.cs.referer}'
            where layer_id in (select id from t_layer where layer_type='BASE' and base_layer_product_name='OS_LEISURE')
            and published_state = 'S'
     
     
            update t_layer set endpoint = '${os.pro.cs.base}' where layer_type='BASE' and base_layer_product_name='OS_LEISURE'
            update t_layer set default_x=436379, default_y=296150, default_zoom = 1 where base_layer_product_name  = 'OS_LEISURE'
            update t_layer set default_x=436379, default_y=296150, default_zoom = 1 where base_layer_product_name  = 'OS_PRO_CS'
            update t_layer set default_x=436379, default_y=296150, default_zoom = 1 where base_layer_product_name  = 'OS_PRO_CS_TOPO'
    
            update t_layer set alias = 'leisure' where base_layer_product_name = 'OS_LEISURE'
       
            insert into t_base_layer_product (name, enabled)
            values ('OS_LEISURE_TOPO', true )
       
            INSERT INTO t_layer (id, name, description, published_state, endpoint, layer_type, owner_id, base_layer_product_name, projection, editable_when_displayed, usergroup_id, alias, link_to_layer_name, deleted, enabled, default_x, default_y, default_zoom)
            SELECT
            nextval('hibernate_sequence'),
            'OS Leisure with MasterMap',
            'OS Leisure with MasterMap',
            'S',
            'http://osondemand.ordnancesurvey.co.uk/ondemand/wms/MAP.do',
            'BASE',
            u.id,
            p.name,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            'leisuretopo',
            'OS_LEISURE'  ,
            false,
            true ,
            436379,
            296150,
            1
            FROM t_user u, t_base_layer_product p
            WHERE p.name = 'OS_LEISURE_TOPO'
            AND u.username = 'mmadmin'
       
            insert into t_endpoint_authentication
            (id, layer_id, user_id, uses_basic_http_auth, uid, password, published_state)
            select nextval('hibernate_sequence'), tlayer.id, tuser.id, true, 'placeholder_uid', 'placeholder_password', 'S'
            from t_layer tlayer, t_user tuser
            where tlayer.base_layer_product_name = 'OS_LEISURE_TOPO'
            and tuser.username='mmadmin'
        
  
            update t_endpoint_authentication
            set uid='${os.ondemand.uid}',
            password='${os.ondemand.password}'
            where layer_id in (select id from t_layer where layer_type='BASE' and base_layer_product_name='OS_LEISURE_TOPO')
            and published_state = 'S'
       
            update t_layer set endpoint = '${os.ondemand.url}' where layer_type='BASE' and base_layer_product_name='OS_LEISURE_TOPO'
        
            insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
            values (nextval('hibernate_sequence'), '''self''', true, 'DEFAULT', 'CSP')

           insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
           values (nextval('hibernate_sequence'), 'http://datapoint.metoffice.gov.uk', true, 'DEFAULT', 'CSP')
           insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
           values (nextval('hibernate_sequence'), 'https://apifa.shoothill.com', true, 'DEFAULT', 'CSP')

          insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
         values (nextval('hibernate_sequence'), 'http://bgs.ac.uk', true, 'DEFAULT', 'CSP')

         insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
         values (nextval('hibernate_sequence'), 'https://osopenspacepro.ordnancesurvey.co.uk', true, 'DEFAULT', 'CSP')

         insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
        values (nextval('hibernate_sequence'), '''self''', true, 'SCRIPT', 'CSP')
        insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
        values (nextval('hibernate_sequence'), '''unsafe-inline''', true, 'SCRIPT', 'CSP')
        insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
            values (nextval('hibernate_sequence'), '''unsafe-eval''', true, 'SCRIPT', 'CSP')
        insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
        values (nextval('hibernate_sequence'), '''self''', true, 'STYLE', 'CSP')
       insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
        values (nextval('hibernate_sequence'), '''unsafe-inline''', true, 'STYLE', 'CSP')

        insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
            values (nextval('hibernate_sequence'), 'http://bgs.ac.uk/feeds/MhSeismology.xml', true, 'CORS', 'CORS')

        update t_layer set name='Zoom Map Stack' where base_layer_product_name='OS_PRO_CS_TOPO'
        update t_layer set name='Leisure Map Stack' where base_layer_product_name='OS_LEISURE_TOPO'
  
       insert into t_endpoint_whitelist (id, endpoint, enabled, connect_type, restriction_type)
            values (nextval('hibernate_sequence'), 'http://osondemand.ordnancesurvey.co.uk', true, 'DEFAULT', 'CSP'
            update t_layer set DISPLAY_POSITION = 10 where base_layer_product_name='OS_PRO_CS';
             update t_layer set DISPLAY_POSITION = 20 where base_layer_product_name='OS_PRO_CS_TOPO';
             update t_layer set DISPLAY_POSITION = 30 where base_layer_product_name='OS_LEISURE';
             update t_layer set DISPLAY_POSITION = 40 where base_layer_product_name='OS_LEISURE_TOPO';
    
        update t_layer set is_default = true where base_layer_product_name='OS_PRO_CS_TOPO';

       INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.layer.modify');</sql>
        INSERT INTO t_role_permission (role_id, permission_id)
            SELECT
                t_role.id,
                t_permission.id
            FROM t_role, t_permission
            WHERE t_role.name in ('role.administrator', 'role.support', 'role.author')
            AND t_permission.name = 'permission.layer.modify'</sql>
   
            insert into t_role_permission
            (role_id, permission_id)
            select role.id, permission.id
            from t_role role, t_permission permission
            where role.name = 'role.support'
            and permission.name = 'permission.data.library.view';

            insert into t_base_layer_product (name, enabled)
            values ('OS_IMAGERY', true )
        
            INSERT INTO t_layer (id, name, description, published_state, endpoint, layer_type, owner_id, base_layer_product_name, projection, editable_when_displayed, usergroup_id, alias, link_to_layer_name, deleted, enabled, default_x, default_y, default_zoom, visible, display_position)
            SELECT
            nextval('hibernate_sequence'),
            'OS Imagery',
            'OS Imagery',
            'S',
            'http://osondemand.ordnancesurvey.co.uk/ondemand/wms/MAP.do',
            'BASE',
            u.id,
            p.name,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            436379,
            296150,
            1  ,
            true,
            30
            FROM t_user u, t_base_layer_product p
            WHERE p.name = 'OS_IMAGERY'
            AND u.username = 'mmadmin'
       
            insert into t_endpoint_authentication
            (id, layer_id, user_id, uses_basic_http_auth, uid, password, published_state)
            select nextval('hibernate_sequence'), tlayer.id, tuser.id, true, 'placeholder_uid', 'placeholder_password', 'S'
            from t_layer tlayer, t_user tuser
            where tlayer.base_layer_product_name = 'OS_IMAGERY'
            and tuser.username='mmadmin'
  
       update t_endpoint_authentication
            set uid='${os.ondemand.uid}',
            password='${os.ondemand.password}'
            where layer_id in (select id from t_layer where layer_type='BASE' and base_layer_product_name='OS_IMAGERY')
            and published_state = 'S'
      
            update t_layer set endpoint = '${os.ondemand.url}' where layer_type='BASE' and base_layer_product_name='OS_LEISURE_TOPO'
   
			update t_layer tl
			set bbox = 
			(select ST_Envelope(ST_Collect(f.geometry))
			from t_layer_fc lfc
			, t_feature f
			where tl.id = lfc.layer_id
			and lfc.feature_collection_id = f.feature_collection_id);

        update t_layer set display_position = 40 where description='OS Imagery' and layer_type='BASE'</sql>

        update t_layer set layers = name where layer_type='WMS'</sql>

            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'Health and Safety Laboratory', null, null, 'S', 'LAYER')
       
            INSERT INTO t_layer (
                id, name, title, layers, description, published_state,
                endpoint, layer_type, owner_id, projection,
                editable_when_displayed, usergroup_id, alias,
                link_to_layer_name, deleted, enabled, visible, use_proxy, queryable)
            SELECT
                nextval('hibernate_sequence'),
                'National Population Database',
                'National Population Database',
                'gb_sample_merge',
                'National Population Database',
                'S',
                'http://inspire.misoportal.com/geoserver/health_and_safety_laboratory_gb_sample_merge/wms',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
    
        update t_layer
             set asset_group_id = (select id from t_asset_group where name = 'Health and Safety Laboratory')
             where name = 'National Population Database'

            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'British Geological Survey', null, null, 'S', 'LAYER')
       
            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
            SELECT
            nextval('hibernate_sequence'),
            'GBR BGS 1:625k Bedrock Lithology',
            'GBR BGS 1:625k Bedrock Lithology',
            'GBR_BGS_625k_BLT',
            'GBR BGS 1:625k Bedrock Lithology',
            'S',
            'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
            FROM t_user u
            WHERE u.username = 'mmadmin'

            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
            SELECT
            nextval('hibernate_sequence'),
            'GBR BGS 1:625k Bedrock Lithostratigraphy',
            'GBR BGS 1:625k Bedrock Lithostratigraphy',
            'GBR_BGS_625k_BLS',
            'GBR BGS 1:625k Bedrock Lithostratigraphy',
            'S',
            'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
            FROM t_user u
            WHERE u.username = 'mmadmin'
     
            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
            SELECT
            nextval('hibernate_sequence'),
            'GBR BGS 1:625k Bedrock Age',
            'GBR BGS 1:625k Bedrock Age',
            'GBR_BGS_625k_BA',
            'GBR BGS 1:625k Bedrock Age',
            'S',
            'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
            FROM t_user u
            WHERE u.username = 'mmadmin'
      
            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
            SELECT
            nextval('hibernate_sequence'),
            'GBR BGS 1:625k Superficial Lithology',
            'GBR BGS 1:625k Superficial Lithology',
            'GBR_BGS_625k_SLT',
            'GBR BGS 1:625k Superficial Lithology',
            'S',
            'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
            FROM t_user u
            WHERE u.username = 'mmadmin'
    
            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
            SELECT
            nextval('hibernate_sequence'),
            'GBR BGS 1:625k Superficial Lithostratigraphy',
            'GBR BGS 1:625k Superficial Lithostratigraphy',
            'GBR_BGS_625k_SLS',
            'GBR BGS 1:625k Superficial Lithostratigraphy',
            'S',
            'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
            FROM t_user u
            WHERE u.username = 'mmadmin'
      
            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
            SELECT
            nextval('hibernate_sequence'),
            'UKContShelf BGS 1:1M Seabed Sediments',
            'UKContShelf BGS 1:1M Seabed Sediments',
            'UKCoShelf_BGS_1M_SBS',
            'UKContShelf BGS 1:1M Seabed Sediments',
            'S',
            'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy, queryable)
            SELECT
                nextval('hibernate_sequence'),
                'GBR BGS 1:50k Bedrock',
                'GBR BGS 1:50k Bedrock',
                'BGS.50k.Bedrock',
                'GBR BGS 1:50k Bedrock',
                'S',
                'https://map.bgs.ac.uk/arcgis/services/BGS_Detailed_Geology/MapServer/WMSServer',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy, queryable)
            SELECT
                nextval('hibernate_sequence'),
                'GBR BGS 1:50k Superficial deposits',
                'GBR BGS 1:50k Superficial deposits',
                'BGS.50k.Superficial.deposits',
                'GBR BGS 1:50k Superficial deposits',
                'S',
                'https://map.bgs.ac.uk/arcgis/services/BGS_Detailed_Geology/MapServer/WMSServer',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy, queryable)
            SELECT
                nextval('hibernate_sequence'),
                'GBR BGS 1:50k Artificial ground',
                'GBR BGS 1:50k Artificial ground',
                'BGS.50k.Artificial.ground',
                'GBR BGS 1:50k Artificial ground',
                'S',
                'https://map.bgs.ac.uk/arcgis/services/BGS_Detailed_Geology/MapServer/WMSServer',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
      
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy, queryable)
            SELECT
                nextval('hibernate_sequence'),
                'GBR BGS 1:50k Mass movement',
                'GBR BGS 1:50k Mass movement',
                'BGS.50k.Mass.movement',
                'GBR BGS 1:50k Mass movement',
                'S',
                'https://map.bgs.ac.uk/arcgis/services/BGS_Detailed_Geology/MapServer/WMSServer',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy, queryable)
            SELECT
                nextval('hibernate_sequence'),
                'GBR BGS 1:50k Linear features',
                'GBR BGS 1:50k Linear features',
                'BGS.50k.Linear.features',
                'GBR BGS 1:50k Linear features',
                'S',
                'https://map.bgs.ac.uk/arcgis/services/BGS_Detailed_Geology/MapServer/WMSServer',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true ,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
            insert into t_layer
                (layer_type, id, date_created, description,
                editable_when_displayed, date_modified,
                name, projection, published_state,
                usergroup_id, owner_id,
                base_layer_product_name, title, js_layer_plugin_name, deleted, endpoint, enabled, use_proxy )
            select
                'GEORSS', nextval('hibernate_sequence'), current_timestamp, 'UK Earthquakes',
                false,current_timestamp,
                'UK Earthquakes', 'EPSG:27700', 'S',
                tuser.usergroup_id, tuser.id,
                null, 'UK Earthquakes',null, false, 'http://bgs.ac.uk/feeds/MhSeismology.xml', true, true
            from t_user tuser
            where username='mmadmin'
        
        update t_layer
            set asset_group_id = (select id from t_asset_group where name = 'British Geological Survey')
            where name in (
            'GBR BGS 1:50k Bedrock',
            'GBR BGS 1:50k Mass movement',
            'GBR BGS 1:50k Linear features',
            'GBR BGS 1:50k Artificial ground',
            'GBR BGS 1:50k Superficial deposits',
            'GBR BGS 1:625k Bedrock Lithostratigraphy',
            'GBR BGS 1:625k Bedrock Age',
            'GBR BGS 1:625k Superficial Lithology',
            'GBR BGS 1:625k Superficial Lithostratigraphy',
            'GBR BGS 1:625k Bedrock Lithology',
            'UKContShelf BGS 1:1M Seabed Sediments',
            'UK Earthquakes')
 
        insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
        values (nextval('hibernate_sequence'), 'Office of National Statistics', null, null, 'S', 'LAYER')
    
        INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable)
        SELECT
            nextval('hibernate_sequence'),
            'ONS 2011 Lower Layer Super Output Area (LSOA) Boundaries',
            'ONS 2011 Lower Layer Super Output Area (LSOA) Boundaries',
            '0',
            'ONS 2011 Lower Layer Super Output Area (LSOA) Boundaries',
            'S',
            'https://mapping.statistics.gov.uk/arcgis/services/LSOA/LSOA_2011_EW_BFE/MapServer/WmsServer',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
        FROM t_user u
        WHERE u.username = 'mmadmin'
    
        INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy, queryable
        )
        SELECT
            nextval('hibernate_sequence'),
            'ONS 2011 Middle Layer Super Output Area (MSOA) Boundaries',
            'ONS 2011 Middle Layer Super Output Area (MSOA) Boundaries',
            '0',
            'ONS 2011 Middle Layer Super Output Area (MSOA) Boundaries',
            'S',
            'https://mapping.statistics.gov.uk/arcgis/services/MSOA/MSOA_2011_EW_BFE/MapServer/WmsServer',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
        FROM t_user u
        WHERE u.username = 'mmadmin'
   
        INSERT INTO t_layer (
             id, name, title, layers,
             description, published_state, endpoint,
             layer_type, owner_id, projection,
             editable_when_displayed, usergroup_id, alias,
             link_to_layer_name, deleted,
             enabled, visible, use_proxy, queryable)
        SELECT
            nextval('hibernate_sequence'),
            'ONS 2011 Workplace Zone (WZ) Boundaries',
            'ONS 2011 Workplace Zone (WZ) Boundaries',
            '0',
            'ONS 2011 Workplace Zone (WZ) Boundaries',
            'S',
            'https://mapping.statistics.gov.uk/arcgis/services/WZ/WZ_2011_EW_BFE/MapServer/WmsServer',
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            true
        FROM t_user u
        WHERE u.username = 'mmadmin'
    
       update t_layer
            set asset_group_id = (select id from t_asset_group where name = 'Office of National Statistics')
            where name in ('ONS 2011 Workplace Zone (WZ) Boundaries', 'ONS 2011 Middle Layer Super Output Area (MSOA) Boundaries', 'ONS 2011 Lower Layer Super Output Area (LSOA) Boundaries')
   
            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'Department for Transport', null, null, 'S', 'LAYER')
      
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy)
            SELECT
                nextval('hibernate_sequence'),
                'Railway network',
                'Railway network',
                'RailNetwork',
                'Railway network',
                'S',
                'http://inspire.esriuk.com/ArcGIS/services/DfT/Stations/MapServer/InspireViewService',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
            INSERT INTO t_layer (
                id, name, title, layers, description,
                published_state, endpoint, layer_type,
                owner_id, projection, editable_when_displayed,
                usergroup_id, alias, link_to_layer_name,
                deleted, enabled, visible, use_proxy)
            SELECT
                nextval('hibernate_sequence'),
                'Railway stations',
                'Railway stations',
                'Stations',
                'Railway stations',
                'S',
                'http://inspire.esriuk.com/ArcGIS/services/DfT/Stations/MapServer/InspireViewService',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
       
           update t_layer
            set asset_group_id = (select id from t_asset_group where name = 'Department for Transport')
            where name in ('Railway network', 'Railway stations')
    

            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'Highways Agency', null, null, 'S', 'LAYER')
      

            INSERT INTO t_layer (
               id, name, title, layers, description,
               published_state, endpoint, layer_type,
               owner_id, projection, editable_when_displayed,
               usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy)
            SELECT
                 nextval('hibernate_sequence'),
                'Road Network',
                'Road Network',
                'RoadNetwork',
                'Road Network',
                'S',
                'http://inspire.esriuk.com/ArcGIS/services/DfT/RoadNetwork/MapServer/InspireViewService',
                'WMS',
                u.id,
                'EPSG:27700',
                TRUE   ,
                u.usergroup_id,
                null,
                null  ,
                false,
                true ,
                true,
                true
            FROM t_user u
            WHERE u.username = 'mmadmin'
      

            update t_layer
            set asset_group_id = (select id from t_asset_group where name = 'Highways Agency')
            where name in ('Road Network')
     
            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'Environment Agency', null, null, 'S', 'LAYER');
       
            insert into t_layer
                (layer_type, id, date_created, description,
                editable_when_displayed, date_modified,
                name, projection, published_state,
                usergroup_id, owner_id,
                base_layer_product_name, title, js_layer_plugin_name, deleted, endpoint, use_proxy)
            select
                'WFS', nextval('hibernate_sequence'), current_timestamp, 'Flood Alerts',
                false,current_timestamp,
                'Flood Alerts', 'EPSG:27700', 'S',
                tuser.usergroup_id, tuser.id,
                null, 'Flood Alerts','osmm.custom.layer.EA.FloodAlerts', false, 'https://apifa.shoothill.com/API/Floods', true
            from t_user tuser
            where username='mmadmin';
       
            insert into t_endpoint_authentication (id, layer_id, user_id, uses_cookie, login_url, published_state, api_key, api_key_name)
            select nextval('hibernate_sequence'), tlayer.id, tlayer.owner_id, true, 'https://apifa.shoothill.com/Account/APILogin/', 'S', 'placeholder_text', 'apiKey'
            from t_layer tlayer where name = 'Flood Alerts';
        
            update t_layer set asset_group_id = (select id from t_asset_group where name = 'Environment Agency')
            where title in ('Flood Alerts');
      
            insert into t_layer
            (layer_type, layers, id, date_created, description,
            editable_when_displayed, date_modified,
            name, projection, published_state,
            usergroup_id, owner_id,
            base_layer_product_name, title, js_layer_plugin_name, deleted, endpoint, use_proxy)
            select
            'WMS','eainspire2011-wms-eaieaew00020008', nextval('hibernate_sequence'), current_timestamp, 'Flood Warning Areas',
            false,current_timestamp,
            'eainspire2011-wms-eaieaew00020008', 'EPSG:27700', 'S',
            tuser.usergroup_id, tuser.id,
            null, 'Flood Warning Areas',null, false, 'http://www.geostore.com/OGC/OGCInterface?INTERFACE=EAINSPIRE2011DIRECT' , true
            from t_user tuser
            where username='mmadmin';
       
            insert into t_endpoint_authentication (id, layer_id, user_id, published_state, uid, uid_name, password, password_name)
            select nextval('hibernate_sequence'), tlayer.id, tlayer.owner_id, 'S', 'placeholder_text', 'UID', 'placeholder_text', 'PASSWORD'
            from t_layer tlayer where name = 'eainspire2011-wms-eaieaew00020008';
        
            update t_layer set asset_group_id = (select id from t_asset_group where name = 'Environment Agency')
            where title in ('Flood Warning Areas');
       
            insert into t_layer
            (layer_type, id, date_created, description,
            editable_when_displayed, date_modified,
            name, projection, published_state,
            usergroup_id, owner_id,
            base_layer_product_name, title, js_layer_plugin_name, deleted, endpoint, use_proxy)
            select
            'WMS', nextval('hibernate_sequence'), current_timestamp, 'Indicative Flood Extents',
            false,current_timestamp,
            'COBRA', 'EPSG:27700', 'S',
            tuser.usergroup_id, tuser.id,
            null, 'Indicative Flood Extents',null, false, 'http://www.geostore.com/OGC/OGCInterface?INTERFACE=COBRA' , true
            from t_user tuser
            where username='mmadmin';
       
            insert into t_endpoint_authentication (id, layer_id, user_id, published_state, uid, uid_name, password, password_name)
            select nextval('hibernate_sequence'), tlayer.id, tlayer.owner_id, 'S', 'placeholder_text', 'UID', 'placeholder_text', 'PASSWORD'
            from t_layer tlayer where name = 'COBRA';
       
            update t_layer set asset_group_id = (select id from t_asset_group where name = 'Environment Agency')
            where title in ('Indicative Flood Extents');
       
            delete from t_map_layer where layer_id in (
            select l.id
            from t_layer l, t_asset_group ag
            where l.asset_group_id = ag.id
            and ag.name in ('Met Office'));

            delete from t_endpoint_authentication where layer_id  in (select l.id
            from t_layer l, t_asset_group ag
            where l.asset_group_id = ag.id
            and ag.name in ('Met Office'));

            delete from t_layer where asset_group_id in (select id from t_asset_group where name in ('Met Office'));

            delete from t_asset_group where name in ('Met Office');
      
            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'Met Office', null, null, 'S', 'LAYER');
     
            insert into t_layer
            (layer_type, id, date_created, description,
            editable_when_displayed, date_modified,
            name, projection, published_state,
            usergroup_id, owner_id,
            base_layer_product_name, title, js_layer_plugin_name, deleted, endpoint, use_proxy)
            select
            'WMTS', nextval('hibernate_sequence'), current_timestamp, 'Met Office Rainfall',
            false,current_timestamp,
            'Met Office Rainfall', 'EPSG:27700', 'S',
            tuser.usergroup_id, tuser.id,
            null, 'Met Office Rainfall','osmm.custom.layer.MetOffice.Rainfall', false, 'http://datapoint.metoffice.gov.uk/public/data/inspire/view/wmts', true
            from t_user tuser
            where username='mmadmin';
      
            insert into t_endpoint_authentication (id, layer_id, user_id, published_state, api_key, api_key_name)
            select nextval('hibernate_sequence'), tlayer.id, tlayer.owner_id, 'S', 'placeholder_text', 'key'
            from t_layer tlayer
            where name='Met Office Rainfall'
       
            update t_layer set asset_group_id = (select id from t_asset_group where name = 'Met Office')
            where title in ('Met Office Rainfall');
      
            update t_endpoint_authentication
            set api_key='${metoffice.rainfall.apikey}'
            where layer_id in (select id from t_layer where name = 'Met Office Rainfall')
            and published_state = 'S'
       
            update t_endpoint_authentication
            set api_key ='${ea.floodalerts.apikey}'
            where layer_id in (select id from t_layer where name = 'Flood Alerts')
            and published_state = 'S'
       
            update t_endpoint_authentication
            set uid ='${ea.floodwarnings.uid}',
            password='${ea.floodwarnings.password}'
            where layer_id in (select id from t_layer where name = 'eainspire2011-wms-eaieaew00020008')
            and published_state = 'S'
        
            update t_endpoint_authentication
            set uid ='${ea.indicativefloods.uid}',
            password='${ea.indicativefloods.password}'
            where layer_id in (select id from t_layer where name = 'COBRA' and title = 'Indicative Flood Extents')
            and published_state = 'S'
       
       update t_role set default_landing_url = '/map' where name = 'role.support'
 
       update t_layer set date_created = current_timestamp where date_created is null and layer_type in ('WMS', 'GEORSS', 'WFS', 'WMTS')</sql>
   

            INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.endpoint.create');

            INSERT INTO t_role_permission (role_id, permission_id)
            SELECT
            t_role.id,
            t_permission.id
            FROM t_role, t_permission
            WHERE t_role.name in ('role.administrator', 'role.support')
            AND t_permission.name IN ('permission.endpoint.create');

      

        insert into t_endpoint (id, endpoint, display_name, use_proxy)
             select nextval('hibernate_sequence'), v.endpoint, v.endpoint, true from
            (select distinct endpoint from t_layer where layer_type in ('WMS', 'WMTS', 'WFS', 'GEORSS', 'BASE')) as


   
       update t_layer as l set endpoint_id = (select id from t_endpoint as e where e.endpoint = l.endpoint)
   
        update t_endpoint_authentication as l set layer_id = (select e.id from t_endpoint as e, t_layer as ll where  ll.endpoint = e.endpoint and l.layer_id = ll.id)
       
        update t_layer set name = layers where layer_type ='WMS' and layers is not null
    
            update t_endpoint_authentication
            set api_key='${metoffice.rainfall.apikey}'
            where endpoint_id in (select endpoint_id from t_layer where name = 'Met Office Rainfall')
            and published_state = 'S'
       
            update t_endpoint_authentication
            set api_key ='${ea.floodalerts.apikey}'
            where endpoint_id in (select endpoint_id from t_layer where name = 'Flood Alerts')
            and published_state = 'S'
      
            update t_endpoint_authentication
            set uid ='${ea.floodwarnings.uid}',
            password='${ea.floodwarnings.password}'
            where endpoint_id in (select endpoint_id from t_layer where name = 'eainspire2011-wms-eaieaew00020008')
            and published_state = 'S'
      
            update t_endpoint_authentication
            set uid ='${ea.indicativefloods.uid}',
            password='${ea.indicativefloods.password}'
            where endpoint_id in (select endpoint_id from t_layer where name = 'COBRA' and title = 'Indicative Flood Extents')
            and published_state = 'S'
      
        update t_endpoint as e set endpoint_type = (select distinct layer_type from t_layer as l where l.endpoint_id = e.id)
      
    
            INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.endpoint.list');

            INSERT INTO t_role_permission (role_id, permission_id)
            SELECT
            t_role.id,
            t_permission.id
            FROM t_role, t_permission
            WHERE t_role.name in ('role.administrator', 'role.support', 'role.author')
            AND t_permission.name IN ('permission.endpoint.list');

   
            update t_endpoint as e set display_name = (select title from t_layer as l where l.endpoint = e.endpoint)
            where exists (select ll.endpoint from t_layer as ll where ll.endpoint= e.endpoint group by ll.endpoint having count(*) = 1);

            update t_endpoint set display_name = 'OS OpenSpace WMTS' where endpoint = 'https://osopenspacepro.ordnancesurvey.co.uk/osmapapi/ts';

            update t_endpoint set display_name = 'OS OnDemand WMS' where endpoint = 'http://osondemand.ordnancesurvey.co.uk/ondemand/wms/MAP.do';
            update t_endpoint set display_name = 'BGS UK Earthquakes' where endpoint = 'http://www.bgs.ac.uk/feeds/MhSeismology.xml';
            update t_endpoint set display_name = 'BGS Bedrock and Superficial Geology' where endpoint = 'http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms';
            update t_endpoint set display_name = 'BGS Detailed Geology' where endpoint = 'https://map.bgs.ac.uk/arcgis/services/BGS_Detailed_Geology/MapServer/WMSServer';
            update t_endpoint set display_name = 'DfT Railway' where endpoint = 'http://inspire.esriuk.com/ArcGIS/services/DfT/Stations/MapServer/InspireViewService';
       
            INSERT INTO t_permission (id, name) VALUES (nextval('hibernate_sequence'), 'permission.feed.enable');

            INSERT INTO t_role_permission (role_id, permission_id)
            SELECT
            t_role.id,
            t_permission.id
            FROM t_role, t_permission
            WHERE t_role.name in ('role.support')
            AND t_permission.name IN ('permission.feed.enable');

      
            insert into t_asset_group (id, name, parent_asset_group_id, usergroup_id, published_state, contains)
            values (nextval('hibernate_sequence'), 'OS OnDemand', null, null, 'S', 'LAYER')
        
            INSERT INTO t_layer (
            id, name, title, layers, description,
            published_state, endpoint, layer_type,
            owner_id, projection, editable_when_displayed,
            usergroup_id, alias, link_to_layer_name,
            deleted, enabled, visible, use_proxy,
            MIN_SCALE_DENOMINATOR, MAX_SCALE_DENOMINATOR,
            date_created, date_modified)
            SELECT
            nextval('hibernate_sequence'),
            'IMA25',
            'OS Imagery',
            'OS Imagery',
            'OS Imagery',
            'S',
            null,
            'WMS',
            u.id,
            'EPSG:27700',
            TRUE   ,
            u.usergroup_id,
            null,
            null  ,
            false,
            true ,
            true,
            true,
            708.66,
            42519.6,
            current_timestamp, current_timestamp
            FROM t_user u
            WHERE u.username = 'mmadmin'
        
        update t_layer
            set asset_group_id = (select id from t_asset_group where name = 'OS OnDemand')
            where name in ('IMA25')
        
        update t_layer
            set endpoint_id = (select id from t_endpoint where display_name = 'OS OnDemand WMS')
            where name in ('IMA25')
   
       delete from t_endpoint_authentication
             where request_url is not null
             and endpoint_id in (select id
                                from t_endpoint
                                where endpoint = 'https://osopenspacepro.ordnancesurvey.co.uk/osmapapi/ts');
    

	
			update t_layer t
			set feature_type = (
			select array_to_string(array_agg(distinct geometrytype(f.geometry)), ',') featuretype
			from t_layer l, t_layer_fc lfc, t_feature f
			where t.id = l.id
			and l.id = lfc.layer_id
			and lfc.feature_collection_id = f.feature_collection_id
			group by l.id)
			where t.layer_type = 'DATA'
		
        update t_map_layer set base_layer = false;
        update t_map_layer set base_layer = true where layer_id in (select id from t_layer where layer_type = 'BASE');</sql>
       
        update t_layer set valid_as_base_layer = false;
     
        update t_layer set alias = base_layer_product_name where layer_type='BASE'
    
            update t_layer
            set alias = 'osi',
            layer_type='WMS',
            valid_as_base_layer = true,
            js_layer_plugin_name = 'osmm.custom.layer.os.OSIMagery'
            where base_layer_product_name = 'OS_IMAGERY';

            update t_layer
            set alias = 'osl',
            layer_type='WMS',
            valid_as_base_layer = true,
            js_layer_plugin_name = 'osmm.custom.layer.os.OSLeisure'
            where base_layer_product_name = 'OS_LEISURE';

            update t_layer
            set alias = 'ospcs',
            layer_type='WMS',
            valid_as_base_layer = true,
            is_default=true,
            js_layer_plugin_name = 'osmm.custom.layer.os.OSPro'
            where base_layer_product_name = 'OS_PRO_CS';

            update t_layer
            set alias = 'oslt',
            link_to_layer_name = 'osl',
            layer_type='WMTS',
            valid_as_base_layer = true,
            js_layer_plugin_name = 'osmm.custom.layer.os.OSLeisureTopo'
            where base_layer_product_name = 'OS_LEISURE_TOPO';

            update t_layer
            set alias = 'ospcst',
            link_to_layer_name = 'ospcs',
            layer_type='WMTS',
            valid_as_base_layer = true,
            js_layer_plugin_name = 'osmm.custom.layer.os.OSProTopo'
            where base_layer_product_name = 'OS_PRO_CS_TOPO';
     
        update t_layer set is_default = false where is_default is null
       
        update t_layer set visible = true where visible is null
     
 update t_layer set valid_as_base_layer = false where valid_as_base_layer is null
       
            update t_layer set layers = name where layer_type in ('WMS', 'WMTS', 'WFS');
            update t_layer set name = description where layer_type in ('WMS', 'WMTS', 'WFS');
      
        update t_map set projection = 'EPSG:27700' where projection is null
   
        insert into t_usergroup
            (id, description, name, last_modified_date, created_date, modified_by_id, created_by_id, enabled, default_usergroup)
            select nextval('hibernate_sequence'), torg.name, torg.name, null, torg.date_created, null, tuser.id, torg.enabled, torg.default_usergroup
            from t_usergroup torg, t_user tuser
            where tuser.username='mmadmin'
  
        update t_user tu1 set usergroup_id = (select tug.id
            from t_usergroup tug, t_user tu, t_usergroup torg
            where tu.usergroup_id = torg.id
            and tug.name = torg.name
            and tu.id = tu1.id)
    
        update t_map tm1 set usergroup_id = (select tug.id
            from t_usergroup tug, t_map tm, t_usergroup torg
            where tm.usergroup_id = torg.id
            and tug.name = torg.name
            and tm.id = tm1.id)

        update t_layer tl1 set usergroup_id = (select tug.id
            from t_usergroup tug, t_layer tl, t_usergroup torg
            where tl.usergroup_id = torg.id
            and tug.name = torg.name
            and tl.id = tl1.id)

        update t_asset_group tl1 set usergroup_id = (select tug.id
            from t_usergroup tug, t_asset_group tl, t_usergroup torg
            where tl.usergroup_id = torg.id
            and tug.name = torg.name
            and tl.id = tl1.id)
   
           insert into t_permission
           (id, name)
           values (nextval('hibernate_sequence'), 'permission.usergroup.create');

           insert into t_permission
           (id, name)
           values (nextval('hibernate_sequence'), 'permission.usergroup.modify');

           insert into t_permission
           (id, name)
           values (nextval('hibernate_sequence'), 'permission.usergroup.list');

           insert into t_role_permission (role_id, permission_id)
           select t_role.id, t_permission.id
           from t_role, t_permission
           where t_role.name in ('role.administrator', 'role.support')
           and t_permission.name in ('permission.usergroup.list',  'permission.usergroup.modify');

           insert into t_role_permission (role_id, permission_id)
           select t_role.id, t_permission.id
           from t_role, t_permission
           where t_role.name in ('role.support')
           and t_permission.name in ('permission.usergroup.create');
      
            update t_layer set name = 'Leisure Map Stack' where description = 'OS Leisure stack';
            update t_layer set name = 'Leisure Map Stack with Topo' where description = 'OS Leisure with MasterMap';
            update t_layer set name = 'Zoom Map Stack' where description = 'OS CS PRO Base Layer';
            update t_layer set name = 'Zoom Map Stack with Topo' where description = 'OS CS PRO with Topo Base Layer';
    
			update t_endpoint set endpoint_type = 'WMS'
			where endpoint = 'http://osondemand.ordnancesurvey.co.uk/ondemand/wms/MAP.do';
		
			update t_endpoint set endpoint_type = 'WMTS'
			where endpoint = 'https://osopenspacepro.ordnancesurvey.co.uk/osmapapi/ts';
	
            update t_asset_group set contains = 'LAYER' where contains is null;
      
   
    	update t_layer_type set enabled = false where type = 'FEED' and name in ('WMTS', 'WFS', 'WCS');
   
            update t_layer
            set js_layer_plugin_name = 'osmm.custom.layer.os.OSImagery'
            where js_layer_plugin_name = 'osmm.custom.layer.os.OSIMagery';
       
            update t_asset_group
            set name = 'Met Office Feeds'
            where name = 'Met Office'
            and usergroup_id is null;

            update t_asset_group
            set name = 'Environment Agency Feeds'
            where name = 'Environment Agency'
            and usergroup_id is null;
      --updated until <changeSet id="RES-1711_rename_feeds" author="sbayliss">
        ----  