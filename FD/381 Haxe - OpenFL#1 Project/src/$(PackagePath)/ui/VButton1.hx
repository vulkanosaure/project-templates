package ui;
import com.vinc.display.VButton;

/**
 * ...
 * @author Vincent Huss
 */
class VButton1 extends VButton
{

	public function new(_upstate:String) 
	{
		super(_upstate);
		
		this.cm = 20;
		
		
		//this.br_overState = 0.1;
		this.br_downState = -0.1;
		
		this.br_disableState = -0.45;
		
		this.y_downState = 5;

		
	}
	
}	