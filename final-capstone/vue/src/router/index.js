import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import store from '../store/index'
import Renter from '../views/Renter.vue'
import Contact from '../views/Contact.vue'
import Landlord from '../views/Landlord.vue'
import Employee from '../views/Employee.vue'
import Unit from '../views/Unit.vue'
import LandlordPropertyListing from '../views/LandlordPropertyListing.vue'
import LandlordUnitListing from '../views/LandlordUnitListing.vue'
import LandlordAddRenterToUnit from '../views/LandlordAddRenterToUnit.vue'
import LandlordMaintenanceRequests from '../views/LandlordMaintenanceRequests.vue'

Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
    mode: 'history',
    base: process.env.BASE_URL,
    routes: [
        {
            path: '/property/:id',
            name: 'unitPage',
            component: Unit,
            meta: {
                requiresAuth: false
            }
        },
        {
            path: '/',
            name: 'home',
            component: Home,
            meta: {
                requiresAuth: false
            }
        },
        {
            path: "/login",
            name: "login",
            components: {default: Login, main: Home},
            meta: {
                requiresAuth: false
            }
        },
        {
            path: "/logout",
            name: "logout",
            components: {default: Logout, main: Home},
            meta: {
                requiresAuth: false
            }
        },
        {
            path: "/register",
            name: "register",
            components: {default: Register, main: Home},
            meta: {
                requiresAuth: false
            }
        },
        {
            path: '/Tenant',
            name: 'renter',
            component: Renter,
            meta: {
                requiresAuth: true
            }
        }, {
            path: '/contact',
            name: 'contact',
            component: Contact,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/Employee',
            name: 'employee',
            component: Employee,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/Owner',
            name: 'landlord',
            component: Landlord,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/owner/addRenterToUnit',
            name: 'addRenterToUnit',
            component: LandlordAddRenterToUnit,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/NewPropertyListing',
            name: 'newpropertylisting',
            component: LandlordPropertyListing,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/NewUnitListing',
            name: 'newunitlisting',
            component: LandlordUnitListing,
            meta: {
                requiresAuth: true
            }
        },
        {
            path: '/MaintenanceRequest/owner',
            name: 'maintenanceowner',
            component: LandlordMaintenanceRequests,
            meta: {
                requiresAuth: true
            }
        },
    ]
})

router.beforeEach((to, from, next) => {
    // Determine if the route requires Authentication
    const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

    // If it does and they are not logged in, send the user to "/login"
    if (requiresAuth && store.state.token === '') {
        next();
    } else {
        // Else let them go to their next destination
        next();
    }
});

export default router;
