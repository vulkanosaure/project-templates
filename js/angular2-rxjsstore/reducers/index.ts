import {StoreModule, combineReducers} from '@ngrx/store';
import {routesReducer} from './routes.reducer';

// const reducer = combineReducers(routes);
const reducer = {
	routes : routesReducer
};

export const store = StoreModule.forRoot(reducer);