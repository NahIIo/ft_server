<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password');

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '}bP$_FFh83Rat7cVJMFj7(+Y.I:#0u|#sDGg{Tk<k` [,|y62D6k=TlN&qd{#uZt');
define('SECURE_AUTH_KEY',  '>A~X[N,+xYqc|tM!uWO#u/9f`0iaY!t1nK!U*X$&@2D8f}w{otqh)(hDw3+I9:H%');
define('LOGGED_IN_KEY',    '*P$+!xzr-EjkhWO(r61Y|4bXJ`%!c{6+{}-qM7-VJvEFYCm.>E}IvFa*{]G/dcCO');
define('NONCE_KEY',        'dvXBIrq=R|yFif3# c6]cA`38tX@+ddPpt/`>J~uY#FnJoeY}{uRbL59AQ@-)_<c');
define('AUTH_SALT',        'V*r+*JVXrX-0;&;f|aV]^1v>>=`mHB&ZQdi5Ezzx%Ft_9,-ece6RH?~.ef_(1}`?');
define('SECURE_AUTH_SALT', 'vH-j|GBjGLr.mSCA&gk;Au{a7<<+y55EH2j)mU,VagpmanaKn]l[d^4-OO$.S+<z');
define('LOGGED_IN_SALT',   'W;(>V?C4of{|D$_&?^6;lt(?$e?%OQI%0zyG1Jnv}XID^|{VVk!@nFM1c&32~<^a');
define('NONCE_SALT',       '=NK)fx]S`ka=a-MQ Pb!C2#d<|V7-WYjTnL*eFp *v]?{Np*y_aZG9eQMG~B>JOf');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
	
/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');