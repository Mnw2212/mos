void main()
{
	// character pointer pointing at the first text cell of the video
	// memory
	
	char* video_memory = (char* ) 0xb8000;
	//displays x at topleft of screen
	*video_memory = 'Kernel Running';
}
