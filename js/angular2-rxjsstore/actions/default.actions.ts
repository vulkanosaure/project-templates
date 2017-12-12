import * as actionTypes from './actionTypes';

export function navigate(route: string) {
	return {type: actionTypes.NAVIGATE, route};
}