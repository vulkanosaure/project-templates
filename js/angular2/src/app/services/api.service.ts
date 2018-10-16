import { environment } from './../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
	
	

	constructor(
		private http:HttpClient,
	) { }
	
	/* 
	getData(uid:string):Observable<any>
	{
		//todo mock
		if(environment.mockApi){
			return this.http.get('assets/mock/getdata.mock.json');
		}
		if(!uid) uid = this.defaultUID;
		let body:any = {companyUid : uid};
		return this.http.post(environment.BASE_URL + '/getData', body);
		
		
		return this.http.get('assets/json/gamedata.json');
		
	}
	 */
	
	
	
	
}
