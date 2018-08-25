<?php

namespace AppBundle\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\CallbackTransformer;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Validator\Constraints\Regex;
use Symfony\Component\Validator\Constraints\Email;

class #{filename} extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
		
        $builder
            ->add('name', null, [
				'label' => 'Nom',
				'attr' => ['class' => 'form-control'],
				'constraints' => [
					new NotBlank(['message' => 'Le champ doit être rempli.']),
				]
			])
			
			
			->add('email', EmailType::class, [
				'label' => 'Email',
				'attr' => ['class' => 'form-control'],
				'constraints' => [
					new NotBlank(['message' => 'Le champ doit être rempli.']),
					new Email(['message' => 'L\'email n\'est pas valide.']),
				]
			])
			
			->add('password', PasswordType::class, [
				'label' => 'Mot de passe',
				'attr' => ['class' => 'form-control'],
				'constraints' => [
					new Regex([
						'pattern' => $pattern,
						'message' => $msg_regex,
					]),
				]
			])
			
			
            ->add('valid', SubmitType::class, ['label' => 'Enregistrer'])
		;
					
	}
		
		
	public function configureOptions(OptionsResolver $resolver)
	{
		$resolver->setDefaults(array(
			'type_form' => 'user',
		));
	}
}