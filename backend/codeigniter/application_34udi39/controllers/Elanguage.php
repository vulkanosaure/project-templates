<?php
defined('BASEPATH') OR exit('No direct script access allowed');


class Elanguage extends CI_Controller {

	
	
	public function index(){
		
		redirect(base_url());
		die();
		
	}

	public function getStats($id_language)
	{
			$query = "SELECT * FROM grades WHERE id_language=".$id_language;
			$r = $this->db->query($query);
			$nbgrade = $r->num_rows($r);
			//trace("nbgrade : ".$nbgrade);
			
			$query = "SELECT * FROM vocabulary WHERE id_language=".$id_language;
			$r2 = $this->db->query($query);
			$nbresult = $r->num_rows($r2);
			//trace("nbresult : ".$nbresult);
				
			foreach($r2->result_array() as $obj)
			{
				if($obj["audio"] == "") $nbgrade--;
			}
			
			$total_global = 0;
			$total_fr_jap = 0;
			$total_jap_fr = 0;
			$total_audio_fr = 0;
			
			
			foreach($r->result_array() as $obj)
			{
				$grade = $obj["grade"];
				//if($grade > 2) $grade = 2;
				$total_global += $grade;
				
				$way = $obj["way"];
				
				if($way=="jap_fr") $total_jap_fr += $grade;
				else if($way=="fr_jap") $total_fr_jap += $grade;
				else if($way=="audio_fr") $total_audio_fr += $grade;
				
			}
			//trace("total_jap_fr : ".$total_jap_fr);
			
			
			$max_point = 3;
			$moy_global = $total_global / ($nbgrade * $max_point) * 100;
			$moy_fr_jap = $total_fr_jap / ($nbresult * $max_point) * 100;
			$moy_jap_fr = $total_jap_fr / ($nbresult * $max_point) * 100;
			$moy_audio_fr = $total_audio_fr / ($nbresult * $max_point) * 100;
			
			
			$output = array();
			
			$output["nbresult"] = $nbresult;
			$output["moy_global"] = round($moy_global, 1);
			$output["moy_fr_jap"] = round($moy_fr_jap, 1);
			$output["moy_jap_fr"] = round($moy_jap_fr, 1);
			$output["moy_audio_fr"] = round($moy_audio_fr, 1);
			
			$output = json_encode($output);
			echo $this->security->xss_clean($output);
			
			
	}


}